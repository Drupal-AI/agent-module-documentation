# image_effects — agent start

Adds ~27 extra image-style effects (watermark, text overlay, smart crop, blur, color ops…) to
core's Image API, for GD and ImageMagick. Depends on `image` + `file_mdm`. Config UI:
**Admin → Config → Media → Image Effects** (`/admin/config/media/image_effects`, route
`image_effects.settings`); effects are added on **Image styles**.

- Catalog of image effect plugins → [configure/effects.md](configure/effects.md)
- Module settings (color/image/font selector choices) → [configure/settings.md](configure/settings.md)
- Selector plugin types it defines + adding one → [plugins/selectors.md](plugins/selectors.md)
- Drush command (convert core Rotate) → [drush/commands.md](drush/commands.md)
- Alter Text Overlay text via hook → [hooks/hooks.md](hooks/hooks.md)
