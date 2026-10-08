<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# tealiumiq (Tealium iQ Tag Management) — agent index

Injects Tealium's **`utag.js`** loader into front-end pages and builds the **`utag_data`** data
layer its tags read. Version **8.x-2.4**, core `^10.2 || ^11`. Depends on core `field` and contrib
`token`. Package `Tealium`. Admin UI at `/admin/config/services/tealiumiq` (route
`tealiumiq.overview`), config form at `.../settings` (`tealiumiq.settings`), default tags at
`.../defaults` (`tealiumiq.defaults`).

## Mechanism (verified from source)
- **Loader URL** — `Tealiumiq::getUtagBaseUrl()`: if `fpd_url` set → `{fpd_url}/{profile}/{environment}`,
  else `https://tags.tiqcdn.com/utag/{account}/{profile}/{environment}`. `getUtagUrl()` appends
  `/utag.js`; `getUtagSyncUrl()` appends `/utag.sync.js` (only when `utagsyncjs_load`). Both return
  NULL when the user is authenticated and `utaganonymous_only` is set.
- **Output paths** (`tealiumiq.module`, skipped on admin routes and when `api_only` is TRUE):
  - **async** (`tag_load: async`) — `hook_page_attachments` attaches library `tealiumiq/tealiumiq_async`
    + `drupalSettings.tealiumiq.tealiumiq` (`utagurl`, `async`, `utagData`); `js/tealiumiq_async.js`
    sets `var utag_data = …` and injects the `utag.js` `<script>`.
  - **sync** (`tag_load: sync`) — `hook_page_top` or `hook_page_bottom` (per `sync_load_position`)
    renders theme `tealium_sync` (`templates/tealium_sync.html.twig`): inline `var utag_data = {json}`
    then `<script src=utag.js>`.
  - `utag.sync.js` is added to `html_head` from `hook_page_attachments` whenever `utagsyncjs_load` is
    on, independent of async/sync.
- **Data layer build** — `Tealiumiq::setProperties()` merges, in order: defaults (`tealiumiq.defaults`,
  gated by `defaults_everywhere`) → `AlterUdoPropertiesEvent` subscribers → per-entity field tags →
  `FinalAlterUdoPropertiesEvent`. `Helper::generateRawElements()` runs each value through tag plugins
  and `processTokens()` (token replace → `PlainTextOutput::renderFromHtml`, i.e. reduced to plain
  text). Result stored in the `Udo` service (namespace `utag_data`).
- **Serialization** — `getPropertiesJson()`: `json_encoded == 'php'` → `json_encode()`, otherwise
  `Json::encode()` (default; install ships the value `drp`, which is neither form option `dru`/`php`
  and so falls through to `Json::encode`).
- **Per-entity meta** — `hook_entity_base_field_info` adds a computed, translatable `tealiumiq` **map**
  base field to every content entity with a base table + canonical link (except comment) for REST
  normalization. Editable values come from a `tealiumiq` **FieldType** added via Field UI; its widget
  serializes `{tag_id: value}` into one text column (read back with `unserialize(..., ['allowed_classes' => FALSE])`).

## Plugin types
- `@TealiumiqTag` (`plugin.manager.tealiumiq.tag`) — a data-layer variable. Shipped: `page_name`,
  `page_url`. Base: `TagBase`.
- `@TealiumiqGroup` (`plugin.manager.tealiumiq.group`) — fieldset grouping. Shipped: `page`.

## Permissions (both `restrict access: TRUE`)
- `administer tealium settings` — the settings form (account/profile/environment/loading).
- `manage global tealium tags` — overview + default tags form.
Treat these as code-deployment rights: a tag container runs arbitrary vendor JS on every visitor.

## Where to look
- Config keys & the two config objects → [config/settings.md](config/settings.md)
- Programmatic data-layer API (service, events, tokens, field, tag plugins) → [api/data-layer.md](api/data-layer.md)
- Context integration submodule → [submodules/tealiumiq_context.md](submodules/tealiumiq_context.md)

## Notes / caveats
- `api_only` = headless mode: the module emits nothing; you output the data layer yourself.
- Consent and PII are **not** handled — the data layer is world-visible page source; integrate a
  consent manager and decide disclosure explicitly.
- `tealium_sync.html.twig` references an `utagsyncurl` variable that `hook_theme` never passes, so
  that inner block is dead code; the `README` "Usage as API / as Context Reaction" sections are TODO
  stubs upstream.
