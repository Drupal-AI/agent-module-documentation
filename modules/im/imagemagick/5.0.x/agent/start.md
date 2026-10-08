# imagemagick — agent start

Registers an `imagemagick` **ImageToolkit** plugin that runs the `convert`/`identify`
(ImageMagick) or `gm` (GraphicsMagick) binaries instead of GD. Depends on `file_mdm`
(metadata) + `sophron` (format/MIME mapping). Select + configure at **Admin → Config →
Media → Image toolkit** (`/admin/config/media/image-toolkit`, route
`system.image_toolkit_settings`).

- Choose the toolkit, binaries path, quality, enabled formats → [configure/toolkit.md](configure/toolkit.md)
- Alter/extend the emitted CLI arguments via events → [extend/events.md](extend/events.md)
- Build & run commands in code (exec manager / arguments / format mapper) → [api/services.md](api/services.md)
- Toolkit operation plugins (scale, crop, convert…) → [plugins/operations.md](plugins/operations.md)
