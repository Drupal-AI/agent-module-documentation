# International Phone (phone_international) — agent index

Adds a `phone_international` **field type** with a country-aware widget (intl-tel-input v25.3+)
that validates and normalizes numbers to **E.164** via libphonenumber, plus a `tel:`-link
formatter and a plain-text formatter. One global setting (`cdn`); a Drush command to fetch the
JS library; a status-report check for the local library version.

- **Field type, widget settings (country list, geolocation, dial code, national number, auto
  placeholder), the two formatters, and the global CDN setting/config** →
  [configure/field-and-widget.md](configure/field-and-widget.md)
- **The `phone_international.validate` service (validate/format) and the reusable form
  element** → [api/validation-service.md](api/validation-service.md)
- **The `phone_international:plugin` Drush command (install intl-tel-input locally)** →
  [drush/plugin-command.md](drush/plugin-command.md)

Key facts: field type id `phone_international` (varchar 256, `preSave()` reformats to E.164);
widget `phone_international_widget`; formatters `phone_international_formatter` (valid → tel:
link, invalid → plain text) and `phone_international_basic_string` (Plain text). Global config
`phone_international.settings.cdn` (bool); settings route `phone_international.settings` at
`/admin/config/phone_international` (permission `administer site configuration`). Requires PHP
lib `giggsey/libphonenumber-for-php` (^9); `ext-zip` for the Drush installer. Core `^10 || ^11`.
