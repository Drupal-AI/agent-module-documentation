<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ai_schema_route` entity & schema attachment

## Entity type

`Entity\AiSchemaRoute` (`@ContentEntityType id = "ai_schema_route"`, base table
`ai_schema_route`) is the single store for all generated schema — content, URL, and views —
keyed by path. Handlers: list builder `AiSchemaRouteListBuilder`, forms `AiSchemaRouteForm`
(add/edit) and `AiSchemaRouteDeleteForm`, `AdminHtmlRouteProvider`, and access handler
`AiSchemaRouteAccessControlHandler`. `admin_permission = "manage url schema"`.

Base fields (`baseFieldDefinitions()`):

| Field | Type | Notes |
|---|---|---|
| `route_path` | string (2048) | Internal path, required; the attachment key. |
| `title` | string (255) | Node title / view title / custom label. |
| `schema_type` | string (512) | Summary of schema.org type(s). |
| `schema_json` | string_long | The JSON-LD payload (one object, a `schemas` array, or a `@graph`). |
| `enabled` | boolean (default TRUE) | Whether to attach on the path. |
| `generated_on` | created | Timestamp. |
| `entity_id` | string (64) | Node id when `source_type = node`. |
| `source_type` | string (32) | `node` or `path`. |

`hook_entity_presave()` (in the `.module`) normalizes non-node rows to `source_type=path` with
empty `entity_id`, and rewrites the current base URL in `schema_json` to the `[site:url]` token
(`SchemaAttacherService::replaceBaseUrlWithToken()`) so schema is portable across environments.

## Routes (entity + generation)

From `ai_jsonld_schema_generator.routing.yml`:

| Route | Path | Access |
|---|---|---|
| `entity.ai_schema_route.*` (canonical/add/edit/delete) | `/admin/ai-schema/url-schemas/...` | `manage url schema` |
| `ai_jsonld_schema_generator.url_page_schema` | `/admin/config/ai-schema/url-page-schema` | `manage url schema` |
| `ai_jsonld_schema_generator.generate_page_schema` | `/admin/config/ai-schema/url-page-schema/generate` | `manage url schema` |
| `ai_jsonld_schema_generator.generate_node` | `/ai-schema-generator/generate/{node}` | `generate ai schema` **+** `_entity_access: node.update` |
| `ai_jsonld_schema_generator.preview_node` | `/node/{node}/ai-schema-generator/preview` | `generate ai schema` **+** `node.update` |
| `ai_jsonld_schema_generator.preview_validate` | `/node/{node}/ai-schema-generator/preview/validate` | `_access: TRUE` (token-gated public preview for Google) |

The Views view `ai_schema_mappings` provides the "Schema mappings" list at
`view.ai_schema_mappings.page_1`; the menu link nests it under the settings page.

## Node edit form integration

`hook_form_alter()` adds an action link to any node edit form whose bundle is enabled and where
the user has `generate ai schema` and the node is not new. The label is *Generate Schema via AI*
(links to `generate_node`, with a JS confirm), *Preview Generated Schema* (unsaved tempstore
preview exists), or *Edit Generated Schema* (a saved `ai_schema_route` exists).

## Editing schema (forms)

- `Form\SchemaPreviewForm` (`preview_node`): shows each block in its own textarea (expanding
  `@graph` into one block per type), lets the editor edit/enable/regenerate, and on save calls
  `SchemaAttacherService::saveSchemaForNode()`. It also stores the preview in a short-lived public
  keyvalue store under a random `bin2hex(random_bytes(16))` token so the Google Rich Results Test
  page (`preview_validate`) can fetch it without the editor's session.
- `Form\AiSchemaRouteForm` (`manage url schema`): edits an `ai_schema_route` directly — one
  textarea per schema block (`schemas[i][json]`) or a single `schema_json` textarea; validates
  each block is JSON with `@context` + `@type`/`@graph`, then re-encodes and saves.
- `Form\UrlPageSchemaForm` (`manage url schema`): adds a path to `page_schema_paths` config and
  redirects to the generate controller.

## Attachment (`SchemaAttacherService::getSchemaFromCurrentPath()`)

For the current request path it loads the enabled `ai_schema_route` row (query with
`accessCheck(FALSE)` — schema is public output by design), normalizes stored JSON to valid
blocks, re-expands the `[site:url]` token to the live base URL, and returns each block. The
`.module` `hook_page_attachments()` then renders them as `application/ld+json` `<script>` blocks
in the head.
