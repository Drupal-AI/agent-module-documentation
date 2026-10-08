# colorbox — agent start

Integrates the jQuery Colorbox lightbox into Drupal via field formatters. Depends on core
`image`. Settings UI: **Admin → Config → Media → Colorbox** (`/admin/config/media/colorbox`,
route `colorbox.admin_settings`). External JS library lives in `/libraries/colorbox`.

- Global lightbox settings (style, transition, dimensions, slideshow, mobile) → [configure/settings.md](configure/settings.md)
- Field formatters that render fields in a lightbox → [theming/formatters.md](theming/formatters.md)
- Alter runtime Colorbox JS options → [hooks/settings-alter.md](hooks/settings-alter.md)
- Install/update the external library via Drush → [drush/plugin.md](drush/plugin.md)
- Services for programmatic activation & gallery ids → [api/services.md](api/services.md)
