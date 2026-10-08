# Settings, node-type setup and the preview iframe (configure)

Route `simple_decoupled_preview.settings_form` → `/admin/config/services/simple_decoupled_preview/settings`
(permission `administer simple decoupled preview`). Form `Drupal\simple_decoupled_preview\Form\SettingsForm`
(`getFormId()` = `simple_decoupled_preview_settings_form`), editing config object
`simple_decoupled_preview.settings`.

## Config keys — `simple_decoupled_preview.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `preview_callback_url` | uri | `''` | Base URL of the decoupled preview page. At render time `hook_entity_view` appends `/{bundle}/{uuid}/{langcode}/{uid}` (trailing slash stripped) and uses it as the iframe `src`. Field suffix shown in the form is `/{bundle}/{uuid}/{langcode}/{uid}`; `#maxlength` 250. |
| `bundles` | sequence(string) | `[]` | Node type machine names that are previewable. Only these get the `preview_iframe` extra field, the iframe render, and preview logging. Stored via `array_filter` so unchecked bundles are dropped. |
| `includes` | sequence(string) | `[]` | Per-bundle JSON:API include paths, keyed by bundle machine name, value = comma-separated relationship paths (e.g. `field_media.field_media_image`). `#tree` is TRUE. Validated by `validateIncludes()` against the resource type via `EntityToJsonApiPreview::isValidInclude()`; invalid paths block save. |
| `delete_log_entities` | boolean | `true` | When true, `hook_cron` deletes expired `preview_log_entity` rows. |
| `log_expiration` | string (seconds) | `'86400'` | Age threshold for cron deletion. Select options: `86400` (1d), `259200` (3d), `604800` (7d), `1209600` (14d), `2592000` (30d), `5184000` (60d), `7776000` (90d). Only visible when `delete_log_entities` is checked. |

`SettingsForm::submitForm()` also warns (messenger) if a selected bundle does not yet have the
`decoupled_preview` view mode enabled. The node-type checkbox options come from
`entity_type.manager` → `node_type` storage (all node types).

## Required setup (mirrors README — all steps needed for a working preview)

1. Enable the module (pulls in `node`, `jsonapi`, `rest`, `restui`, and the
   `simple_decoupled_preview_jsonapi` submodule).
2. At the settings route, set `preview_callback_url`, check the node `bundles`, and (optionally) fill
   `includes` per bundle.
3. REST resources UI (`/admin/config/services/rest`, provided by `restui`): enable the **Simple
   Decoupled Preview JSON** resource (`simple_decoupled_preview_json`) — GET method, `json` format,
   and the authentication provider(s) the front end will use.
4. Permissions: grant `restful get simple_decoupled_preview_json` ("Access GET on Simple Decoupled
   Preview JSON resource") to the role(s) the front end authenticates as. (See
   [../api/rest.md](../api/rest.md) for what that endpoint returns.)
5. Enable CORS in `services.yml` if the front end is on another origin.
6. On each content type: set **Preview before submitting** to Optional/Required (Submission form
   settings), and enable the **Decoupled Preview** view mode on the *Manage display* tab
   (view mode `node.decoupled_preview`, shipped disabled in `config/optional`).

## The preview button flow (`.module`)

- `hook_form_alter` appends `simple_decoupled_preview_preview_submit` to the node form's `preview`
  action `#submit`.
- `simple_decoupled_preview_preview_submit()` — if the entity's bundle is in `bundles` **and** the
  `decoupled_preview` view mode is active for that bundle, it calls
  `simple_decoupled_preview.logger->logEntity($entity)` and redirects to `entity.node.preview` with
  `view_mode_id = decoupled_preview`.
- `simple_decoupled_preview_form_node_preview_form_select_alter()` hides the view-mode `select` on
  the preview page when `view_mode_id === 'decoupled_preview'`.

## The iframe (`hook_entity_view` + theme)

- `hook_entity_extra_field_info` adds a display extra field `preview_iframe` (hidden by default) to
  each configured bundle.
- `hook_entity_view` — for the `decoupled_preview` view mode on a configured bundle with a non-empty
  `preview_callback_url`, and when the route parameter `node_preview` is a node, it builds
  `$build['preview_iframe']` as an `inline_template` `<iframe class="preview-iframe" src="{{ url }}">`
  where `url = rtrim(preview_callback_url,'/') . '/' . bundle . '/' . uuid . '/' . langcode . '/' . currentUser()->id()`,
  attaching library `simple_decoupled_preview/iframe_preview` (`css/iframe_preview.css`, a 16:9
  responsive frame). The URL is inserted as an iframe `src` in the editor's browser; it is **not**
  fetched server-side.
- `hook_theme` registers `node__decoupled_preview` (base hook `node`); template
  `templates/node--decoupled-preview.html.twig` renders only `{{ content.preview_iframe }}`.

## Cleanup (`hook_cron`)

If `delete_log_entities` is true and `log_expiration` is set, cron calls
`PreviewLogger::deleteExpiredLoggedEntities(time() - log_expiration)`, which deletes up to 50
`preview_log_entity` rows older than the threshold per run (`accessCheck(FALSE)`).
