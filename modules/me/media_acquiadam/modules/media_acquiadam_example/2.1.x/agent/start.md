# Media: Acquia DAM - Example Configuration — agent index

Config-only starter submodule of [media_acquiadam](../../../../2.1.x/agent/start.md). Installs example DAM
media types + fields + displays; no settings page (`configure` null), no permissions, no services.

Key facts:
- Installs 5 media types via `config/install`: `acquia_dam_asset`, `acquia_dam_audio`,
  `acquia_dam_document`, `acquia_dam_image`, `acquia_dam_video`, with `field_acquiadam_asset_*` fields and
  default form/view displays (plus optional media_library/thumbnail/embedded displays in `config/optional`).
- `hook_install()`: if `lightning_media` is enabled, adds the `acquiadam` Entity Browser widget for each
  media type to the `media_browser` entity browser.
- **One-shot import**: `hook_requirements()` errors on reinstall once `media.type.acquia_dam_asset` exists,
  and warns that the module can be safely uninstalled afterwards (imported config remains).
- `media_acquiadam_example_update_8201()` unmaps the removed DAM `status` field from the example types.
- Recommended flow: enable → config imported → uninstall → customize the media types/fields.
