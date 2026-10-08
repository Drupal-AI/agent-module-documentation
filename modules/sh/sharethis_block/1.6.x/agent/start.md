# ShareThis Block — agent index

Loads the third-party **ShareThis** social-share JavaScript (from `platform-api.sharethis.com`) for your
account's property ID and exposes an **inline** or **sticky** share-buttons block. One settings form, one
permission, one block plugin. No Drush, no plugin types. Config schema provided.

- **Settings form, config keys, permission, placing the block, how the library URL is built** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config route `sharethis_block.configuration` → `/admin/config/user-interface/sharethis`
  (permission `administer sharethis_block`).
- Config object `sharethis_block.configuration`: `sharethis_property` (string), `sharethis_inline` (bool).
- `hook_library_info_alter` builds the remote JS URL
  `//platform-api.sharethis.com/js/sharethis.js#property=<id>&product=<inline-share-buttons|sticky-share-button>`.
- Block plugin id `sharethis` attaches `sharethis_block/sharethis.core`; inline mode also prints
  `<div class="sharethis-inline-share-buttons">`. External library is commercial (`gpl-compatible: false`).
