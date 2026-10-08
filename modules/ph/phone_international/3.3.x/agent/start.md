# International Phone (phone_international) — agent index

Adds a `phone_international` **field type** with a country-aware widget (intl-tel-input) that
validates and normalizes numbers to **E.164** via libphonenumber, and a formatter that
renders `tel:` links. One global setting (`cdn`); a Drush command to fetch the JS library.

- **Field type, widget settings (country list/geolocation), formatter, and the global CDN
  setting/config** → [configure/field-and-widget.md](configure/field-and-widget.md)
- **The `phone_international.validate` service (validate/format) and the reusable form
  element** → [api/validation-service.md](api/validation-service.md)
- **The `phone_international:plugin` Drush command (install intl-tel-input locally)** →
  [drush/plugin-command.md](drush/plugin-command.md)

Key facts: field type id `phone_international` (varchar 256, `preSave()` reformats to E.164);
widget `phone_international_widget`; formatter `phone_international_formatter` (valid → tel:
link, invalid → plain text). Global config `phone_international.settings.cdn` (bool); settings
route `phone_international.settings` at `/admin/config/phone_international` (permission
`administer site configuration`). Requires PHP lib `giggsey/libphonenumber-for-php`.
