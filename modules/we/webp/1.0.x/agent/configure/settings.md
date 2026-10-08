# Configure WebP

Form `SettingsForm` at `/admin/config/media/webp/settings` (route `webp.settings_form`,
permission `administer site configuration`). Simple config `webp.settings`
(schema `config/schema/webp.schema.yml`).

Keys (default from `config/install/webp.settings.yml`):
```yaml
quality: 75      # WebP compression quality, 1–100 (higher = larger, better looking)
```

Only one setting: the encoding **quality** used by the GD toolkit when creating `.webp` copies.
Lower it for smaller files, raise it for fidelity. There is no per-image-style override in this
version; the value applies to all generated WebP derivatives.
