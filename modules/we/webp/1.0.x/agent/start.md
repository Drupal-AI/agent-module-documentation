# webp — agent start

Generates `.webp` copies of image-style derivatives and injects them into responsive-image
`<picture>` sources. Depends on core `image`; needs PHP **ext-gd**. Global settings:
**Admin → Config → Media → WebP settings** (`/admin/config/media/webp/settings`,
route `webp.settings_form`, permission `administer site configuration`).

- Quality setting → [configure/settings.md](configure/settings.md)
- Webp service (create/delete/srcset helpers) → [api/webp-service.md](api/webp-service.md)
- Responsive-image / entity hooks + on-demand routing → [extend/integration.md](extend/integration.md)
- ImageAPI Optimize processor `webp_webp` → [plugins/imageapi-processor.md](plugins/imageapi-processor.md)
