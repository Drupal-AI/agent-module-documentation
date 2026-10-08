# fontawesome — agent start

Adds a `fontawesome_icon` field type + CKEditor icon dialog and loads the Font Awesome
library (CDN or local). Config UI: **Admin → Config → Content authoring → Font Awesome
settings** (`/admin/config/content/fontawesome`, route `fontawesome.admin_settings`).
No hard module dependencies. Submodules: `fontawesome_iconpicker_widget`, `fontawesome_media`.

- Global settings (CDN vs local, method, style files, shim) → [configure/settings.md](configure/settings.md)
- Icon metadata service + alter hooks → [api/manager-and-hooks.md](api/manager-and-hooks.md)
- Download the library via Drush → [drush/commands.md](drush/commands.md)
- Permission gating advanced icon settings → [permissions/permissions.md](permissions/permissions.md)
- Render/theme icon markup (field type, formatter, Twig) → [theming/icon-rendering.md](theming/icon-rendering.md)
