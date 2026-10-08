<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Telephone Plus (telephone_plus) — agent index

Defines the **`telephone_plus_field`** field type: one phone number bundled with a title, an
extension, supplementary text and a 2-letter country code, displayed as plain text or a **`tel:`
link**. Parsing, validation and display formatting are all delegated to the
`giggsey/libphonenumber-for-php-lite` library through two thin helper classes,
`TelephonePlusValidator` (wraps `PhoneNumberUtil::parse`, returns a bool) and
`TelephonePlusFormatter` (produces the RFC3966 `tel:` URL and the national/international display
text). The field ships one widget (`telephone_plus_widget`) whose element-validate handler rejects
numbers `libphonenumber` cannot parse, and one active formatter (`telephone_plus`) with two legacy
formatters (`telephone_plus_link`, `telephone_plus_plain`) kept only for back-compat. Output is
rendered through the `telephone_plus_item` theme hook / `telephone-plus-item.html.twig` template
(Twig auto-escaping applies to every variable).

There is **no settings page, no routes, no services, no permissions and no drush** — all
configuration is per-field (storage + field settings) and per-formatter (form/view display).
Storage settings decide whether the title and supplementary columns even exist in the schema; field
settings pick the default country code and whether editors may change it.

- Depends on: `drupal:field`, `drupal:telephone` (core). Library: `giggsey/libphonenumber-for-php-lite:^9.0`, `php:>=8.4`.
- Core: `^9 || ^10 || ^11`. Package: `Field types`. Version **2.1.3**.
- No `configure` route / settings form. Provides **no** config schema, **no** permissions, **no** drush, **no** plugin types.
- Optional soft integration: a **Feeds** target (`\Drupal\feeds\...` classes are only referenced, Feeds is not a hard dependency).

## What you'd do → where

- **Add the field; set which columns/country-code/formatter options exist; migrate the deprecated
  formatters; import via Feeds** → [fields/telephone-plus-field.md](fields/telephone-plus-field.md)

## Key facts (real machine names)

- Field type: `telephone_plus_field` (`Plugin/Field/FieldType/TelephonePlusField`), `default_widget =
  telephone_plus_widget`, `default_formatter = telephone_plus`.
- Properties: `telephone_title`, `country_code` (required), `telephone_number` (required),
  `telephone_extension`, `telephone_supplementary`, `display_international_number` (bool, required).
- Storage settings: `title_enabled`, `supplementary_enabled` (both default `FALSE`; each gates a DB
  column). Field settings: `default_country_code` (required), `country_code_enabled` (default `FALSE`).
- Widget: `telephone_plus_widget` (`Plugin/Field/FieldWidget/TelephonePlusWidget`); element-validate
  callback `TelephonePlusWidget::validateTelephoneNumber` → sets error "Invalid telephone number."
- Formatters: `telephone_plus` (active, `TelephonePlusFieldFormatter`, settings `link` + `vcard`,
  both default `TRUE`); `telephone_plus_link` and `telephone_plus_plain` (both `@deprecated` in 2.x,
  see issue 3455751).
- Helper classes (plain PHP, instantiated with `new`, not services):
  `Drupal\telephone_plus\TelephonePlusValidator::isValid()`,
  `Drupal\telephone_plus\TelephonePlusFormatter::url()` (RFC3966 `tel:` URI) and `::text($intl)`.
- Feeds target: `@FeedsTarget(id = "telephone_plus")` (`Feeds/Target/TelephonePlus`), maps all six
  properties.
- Theme hook: `telephone_plus_item` (vars: `title`, `number`, `url`, `extension`, `supplementary`,
  `vcard`) → `templates/telephone-plus-item.html.twig`.
- Hooks: `hook_help` (`help.page.telephone_plus`), `hook_theme`, `hook_preprocess_field` (adds
  `p-tel h-card` classes when `#vcard`). Update hook: `telephone_plus_update_8001` (rewrites legacy
  `telephone_plus_link`/`telephone_plus_plain` components to `telephone_plus`).
