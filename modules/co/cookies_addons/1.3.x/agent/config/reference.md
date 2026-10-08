<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookies Addons — config, routes & permissions reference (all submodules)

Single-page map of everything the six submodules add. Enable each submodule independently; the
parent `cookies_addons` module adds nothing itself.

## Config objects (simple config; schema in each submodule's `config/schema/`)

| Config object | Key | Format (per line) | Set at |
|---|---|---|---|
| `cookies_addons_blocks.settings` | `blocks` (text) | `block_id\|service` | `/admin/config/system/cookies-addons-blocks` |
| `cookies_addons_paragraphs.settings` | `paragraphs` (text) | `paragraph_id\|service` | `/admin/config/system/cookies-addons-paragraphs` |
| `cookies_addons_views.settings` | `views` (text) | `view_id\|display_id\|service` | `/admin/config/system/cookies-addons-views` |

`cookies_addons_fields` stores its gate as a **field formatter third-party setting**
(`field.formatter.third_party.cookies_addons_fields` → `cookies_service`), set per field on Manage
display — no settings form. `cookies_addons_embed_iframe` / `_embed_video` are text-format
**filter** plugins configured on the filter format; their schemas
(`filter.settings.cookies_addons_embed_*_filter`) have an empty mapping (no settings).

## Config install (embed_iframe only)

- `cookies.cookies_service.iframe` — a `cookies_service` entity id `iframe`, label "Iframes other
  than YouTube", `consentRequired: true`, group `iframes`.
- `cookies.cookies_service_group.iframes` — the "Iframes" service group.

## Routes

| Route | Path | Method | Permission | Purpose |
|---|---|---|---|---|
| `cookies_addons_blocks.get_block` | `/cookies-addons-blocks/get-block/{block_id}/{service}` | POST | `access content` | AJAX re-render of a gated block |
| `cookies_addons_blocks.settings` | `/admin/config/system/cookies-addons-blocks` | — | `administer site configuration` | Settings form |
| `cookies_addons_paragraphs.get_paragraph` | `/cookies-addons-paragraphs/get-paragraph/{paragraph_id}/{service}` | POST | `access content` | AJAX re-render of a gated paragraph |
| `cookies_addons_paragraphs.settings` | `/admin/config/system/cookies-addons-paragraphs` | — | `administer site configuration` | Settings form |
| `cookies_addons_views.get_view` | `/cookies-addons-views/get-view/{view_id}/{display_id}/{service}/{arguments}` | POST | `access content` | AJAX render of a gated view (view display access still enforced by the `#type => view` element) |
| `cookies_addons_views.settings_form` | `/admin/config/system/cookies-addons-views` | — | `administer cookies_addons_views configuration` | Settings form |
| `cookies_addons_fields.get_field` | `/cookies-addons-fields/get-field/{field_id}/{service}/{view_mode}` | POST | `access content` | AJAX render of a gated field; controller re-checks entity + field `view` access and validates the view mode |

## Permissions

No submodule ships a `*.permissions.yml`. Note: `cookies_addons_views.settings_form` requires
`administer cookies_addons_views configuration`, a permission **not defined anywhere in the
project** — so that route fails closed (the Views settings form is effectively unreachable until the
permission is provided elsewhere). The Blocks and Paragraphs settings forms use the core
`administer site configuration` permission and work normally.

## Libraries / JS

Each placeholder submodule ships `js/cookies-addons-<type>.js` (a `Drupal.behaviors.*`) depending on
`cookies/cookies.lib` + `core/drupal.ajax`. Embed submodules ship a filter JS that restores
`data-src`→`src` on consent; `cookies_addons_embed_video` attaches the `cookies_video` module's
`cookies_video/cookies_video_embed_field` library rather than its own placeholder.

## Install/update hooks

Only `cookies_addons_embed_video.install` → `cookies_addons_embed_video_update_8001()`, a one-time
config fix renaming the mistyped filter id `cookies_addons_embed_viedeo_filter` to
`cookies_addons_embed_video_filter` across all `filter.format.*`.
