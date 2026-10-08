<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — the design-system URL

## Install / enable
`drush en design_system -y`. Depends on core `toolbar`. No other requirements. Optionally enable
`gin_toolbar` for a Gin-styled toolbar icon.

## Config object
- Name: `design_system.settings` (schema `config/schema/design_system.schema.yml`).
- Single key `design_system_url` (`type: string`).
- Install default (`config/install/design_system.settings.yml`): `internal:/storybook/`.

Read/write via Drupal config:
```php
\Drupal::config('design_system.settings')->get('design_system_url');
```

## Settings form
`src/Form/DesignSystemSettingsForm.php` (`DesignSystemSettingsForm extends ConfigFormBase`,
form id `design_system_settings`, editable config `design_system.settings`).

- Route `design_system.settings` → `/admin/config/user-interface/settings`; requires
  `administer site configuration`.
- One `textfield` `design_system_url` (size 80, maxlength 2048).
- On display, the stored URI is passed through `getUriAsDisplayableString()`, which strips a
  leading `internal:` scheme so the user sees a plain path.
- Element validation `validateUriElement()` calls `getUserEnteredStringAsUri()`: a schemeless
  entry is mapped to an `internal:` URI, and a manually entered internal path must start with
  `/`, `?`, or `#` (else a form error). This mirrors core's link-field URI handling.
- `submitForm()` saves the (possibly `internal:`-prefixed) value straight into config.

## Notes for agents
- To point the link at an external design system, enter a full absolute URL (e.g.
  `https://storybook.example.com/`); to use an in-site path, enter `/storybook/` (stored as
  `internal:/storybook/`).
- The value is consumed by the display controller via `Url::fromUri(...)` — see
  [`../routes/display.md`](../routes/display.md).
