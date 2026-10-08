# Gatsby — configuration

Admin form `GatsbyAdminForm` at `/admin/config/services/gatsby/settings` (route
`gatsby.gatsby_admin_form`, permission `administer gatsby`, editable config `gatsby.settings`).

## `gatsby.settings` keys (defaults from `config/install/gatsby.settings.yml`)

| Key | Default | Meaning |
|---|---|---|
| `server_url` | `''` | Gatsby server URL(s), comma-separated. Used by preview button + iframe. |
| `preview_callback_url` | `''` | Preview webhook URL(s) (e.g. `localhost:8000/__refresh`). Enables preview logging. |
| `incrementalbuild_url` | `''` | Build webhook URL(s) to trigger incremental/full builds. Enables build logging. |
| `contentsync_url` | `''` | Gatsby 4 Content Sync base URL (no trailing slash). |
| `path_mapping` | `''` | One `\/drupal\|\/gatsby` mapping per line (parsed by `PathMapping::parsePathMapping`). |
| `build_published` | `true` | When true, only **nodes** are acted on for builds (non-node entities skipped). |
| `supported_entity_types` | `[]` | Content entity type IDs sent to Gatsby (checkboxes). Nothing fires until set. |
| `publish_private_files` | `false` | If true, `private://` files are also sent (default: private files ignored). |
| `log_json` | `false` | Log each JSON payload POSTed to preview. Debug only — never production. |
| `custom_source_plugin` | `''` | Sends `x-gatsby-cloud-data-source` header for non-`gatsby-source-drupal` plugins. |
| `prevent_selfreferenced_entities` | `false` | Skip logging same-type/bundle referenced entities (avoids huge payloads). |
| `delete_log_entities` | `false` | Enable cron pruning of old Fastbuilds log entities. |
| `log_expiration` | `'604800'` | Seconds to keep log entities (7 days). Select list on the form. |
| `number_items_delete` | `500` | Max log entities deleted per cron run. |

Schema: `config/schema/gatsby.schema.yml` (`gatsby.settings` is a `config_object`; URL fields are
typed `uri`). Validation (`validateForm`) runs `FILTER_VALIDATE_URL` on each comma-split URL.

## Per node type: enable the preview button

`gatsby_form_alter()` adds a "Gatsby Preview" fieldset to the node-type add/edit form **only when
`node` is in `supported_entity_types`**. Stored as third-party setting
`node.type.<bundle>.third_party.gatsby.preview` (boolean, schema `node.type.*.third_party.gatsby`).
The actual "Open Gatsby Preview" button appears on the node edit form only when both a `server_url`
and `preview_callback_url` exist and the node type has the preview flag; it also **requires Content
Moderation** on the bundle (otherwise a warning shows and the button is disabled). Clicking it forces
`moderation_state` to `draft`, saves, and opens the mapped Gatsby preview URL in a new window.

## In-form iframe preview

`hook_entity_extra_field_info()` registers a `gatsby_iframe_preview` display pseudo-field for every
supported entity type/bundle (hidden by default). Enable it on *Manage display* for a view mode;
`gatsby_entity_view()` then renders `<iframe src="{server_url}{mapped path}">`. Requires `server_url`.
(Known issue: can conflict with BigPipe — disable BigPipe or the iframe if pages misload.)

## Path mapping

`PathMapping::getPath()` resolves an entity's alias, blanks it if it equals the site front page, then
applies any `path_mapping` override. Used by both the preview button and the iframe `src`.
