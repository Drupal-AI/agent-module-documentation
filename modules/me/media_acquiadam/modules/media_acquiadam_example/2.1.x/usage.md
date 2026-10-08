A config-only starter submodule that installs example Media types, fields, and form/view displays for Acquia DAM assets so a site has a working DAM media setup out of the box.

---

`media_acquiadam_example` ships no runtime code beyond install hooks — its value is the `config/install`
bundle: five example media types (`acquia_dam_asset`, `acquia_dam_audio`, `acquia_dam_document`,
`acquia_dam_image`, `acquia_dam_video`), their `field_acquiadam_asset_*` storages/instances, and default
entity form/view displays (plus optional media-library/thumbnail/embedded displays). On install, if
`lightning_media` is present it also registers the `acquiadam` Entity Browser widget for each type on the
`media_browser`. It is a one-shot import: `hook_requirements()` blocks reinstall once
`media.type.acquia_dam_asset` exists and advises that the module can be safely uninstalled afterwards (the
imported config stays). An update hook removes an obsolete `status` field mapping from the example media
types. Use it to bootstrap, then uninstall and adjust the config to taste.

---

- Install ready-made Acquia DAM media types (asset, audio, document, image, video) in one step.
- Get default `field_acquiadam_asset_*` fields wired to the `acquiadam_asset` media source.
- Get sensible default form and view displays for DAM media without building them by hand.
- Register the Acquia DAM asset browser widget on the Lightning Media `media_browser` automatically.
- Provide media-library and thumbnail displays for DAM media types.
- Bootstrap a demo/POC of the DAM integration quickly.
- Serve as a reference for how to map DAM metadata to media fields.
- Uninstall after import (config persists) to keep the module list clean.
- Avoid re-import mistakes — reinstall is blocked once the example config exists.
- Start from working config and then customize field mappings per site.
- Seed a training/staging environment with DAM media types.
- Use alongside `media_acquiadam_report` for a complete example setup.
- Copy its `config/install` YAML as a template for custom DAM media types.
- Provide the `embedded` document display used for inline DAM documents.
- Give site builders a fast path from "module enabled" to "editors picking assets".
