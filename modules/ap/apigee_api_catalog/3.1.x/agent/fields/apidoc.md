# The `apidoc` content type, its fields, and the spec renderer

Installing the module imports a node type **`apidoc`** (config `node.type.apidoc`, label
"OpenAPI Doc", `new_revision: true`, `preview_mode: 1`, submitted-by hidden) plus the fields below.
Each documented API is one `apidoc` node. There is no settings form — you operate everything through
this node type, its Manage display, and the two Views (see [../views/catalog.md](../views/catalog.md)).

## Fields (`node.apidoc`)

| Field machine name | Type | Label | Notes |
|---|---|---|---|
| `field_apidoc_spec` | `file` | OpenAPI specification | The spec snapshot actually rendered. Extensions `yaml json`; stored at `public://apidoc_specs`; cardinality 1. Filled directly on upload, or written by `SpecFetcher` when the source is a URL. |
| `field_apidoc_spec_file_source` | `list_string` | Specification source type | Allowed values `file` → "File", `url` → "URL". Drives which of the two input fields is required/visible on the form. Not required. |
| `field_apidoc_file_link` | `file_link` | URL to OpenAPI specification file | The remote spec URL when source is `url`. Extensions `yaml json`. Carries the `ApiDocFileLink` validation constraint (a HEAD request checks the URL resolves). |
| `field_apidoc_spec_md5` | `string` | OpenAPI specification file MD5 | Checksum of the last-stored spec; used to decide whether a re-fetch actually changed. Hidden on the form/display. |
| `field_apidoc_fetched_timestamp` | `timestamp` | Spec fetched from URL timestamp | Unix time of the last URL fetch; sent as `If-Modified-Since` on conditional GETs. Hidden on the form/display. |
| `field_api_product` | `entity_reference` → `api_product` | API Product | References an Apigee Edge API Product (`default:api_product` selection handler). This is the field that ties the doc to Apigee; requires the `apigee_edge` dependency. |
| `body` | `text_with_summary` | (core) | Optional editorial description, shown above the rendered spec. |

Form display `node.apidoc.default`: `field_apidoc_spec_file_source` is an `options_select`,
`field_apidoc_spec` a `file_generic` widget, `field_apidoc_file_link` a `file_link_default` widget,
`field_api_product` an autocomplete; the md5/timestamp fields are hidden. `hook_form_node_form_alter`
adds `#states` so the file widget shows/requires only when source is `file`, and the URL widget only
when source is `url` (see [../hooks/node-lifecycle.md](../hooks/node-lifecycle.md)).

## How the spec is rendered (SmartDocs formatter)

View display `node.apidoc.default` renders `field_apidoc_spec` with the formatter
**`apigee_api_catalog_smartdocs`** (`src/Plugin/Field/FieldFormatter/SmartDocsFormatter.php`,
extends `FileFormatterBase`, applies to `file` fields). It does **not** print spec content into the
page; instead it:

- emits an `<app-root>Loading...</app-root>` element and a `<base href>` head tag,
- attaches libraries `apigee_api_catalog/js_yaml`, `.../smartdocs_integration`, `.../smartdocs`,
- passes each file's public URL + extension in `drupalSettings.smartdocsFieldFormatter`.

`js/smartdocs_integration.js` then fetches the file client-side, parses YAML with js-yaml (JSON is
used as-is), stores it in `sessionStorage['specs']`, and Google's external SmartDocs Angular app
(loaded from `gstatic.com`, library `smartdocs`) draws the interactive docs. Known limitation
(README): SmartDocs renders one spec per page and expects the `/api/{entityId}` URL pattern.

### Switching to Swagger UI (or another formatter)

The spec is a normal `file` field, so any file-field formatter works. To use Swagger UI instead of
SmartDocs (per README):

1. Install + enable [`swagger_ui_formatter`](https://www.drupal.org/project/swagger_ui_formatter)
   and its JS library.
2. Go to **Structure → Content types → OpenAPI Doc → Manage display** (route
   `entity.entity_view_display.node.default`, bundle `apidoc`).
3. Set the **OpenAPI specification** field format to the Swagger UI formatter and save.

Set it in code with:

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'apidoc', 'default')
  ->setComponent('field_apidoc_spec', ['type' => 'swagger_ui_formatter_swagger_ui'])
  ->save();
```

## Config-schema note

The module ships **no** `config/schema/*` — the field/type/display config it installs relies on
core's field, node and views schemas. `config/install/` holds the type + field storage/instances +
default form/view displays; `config/optional/` holds the two Views and the `body` field.
