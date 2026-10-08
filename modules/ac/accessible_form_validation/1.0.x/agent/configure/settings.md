<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessible Form Validation — settings

Config object `accessible_form_validation.settings` (schema in `config/schema/`, defaults in
`config/install/`). Settings form `Drupal\accessible_form_validation\Form\SettingsForm` (a plain
`ConfigFormBase`) at `/admin/config/user-interface/accessible-form-validation`, route
`accessible_form_validation.settings`, menu link under `system.admin_config_ui`. Access:
core permission **`administer site configuration`** (no module-specific permission).

| Key | Type | Default (`config/install`) | Effect |
|---|---|---|---|
| `default_theme_enabled` | boolean | `true` | Attach the library on forms rendered while the active theme equals `system.theme:default`. |
| `admin_theme_enabled` | boolean | `true` | Attach the library on forms rendered while the active theme equals `system.theme:admin`. |
| `default_theme_error_message_selector` | string | `''` | Optional bare CSS class name (no leading `.`) for the inline error container, applied **on the default theme only**. Blank = use the theme default. |

## Attach logic (`accessible_form_validation_form_alter`)

For **every** form, the module reads the config, the active theme, and `system.theme` (`default`,
`admin`), then:

- If `default_theme_enabled` AND active theme == default theme → attach
  `accessible_form_validation/accessible_form_validation`.
  - If `default_theme_error_message_selector` is non-empty → set
    `drupalSettings.accessibleFormValidation.errorMessageSelector` to it.
  - Else if active theme is `claro` or `gin` → set that selector to `form-item__error-message`.
- If `admin_theme_enabled` AND active theme == admin theme → attach the same library.
  - If active theme is `claro` or `gin` → set the selector to `form-item__error-message`.
    (The custom `default_theme_error_message_selector` is **not** consulted on the admin-theme path.)
- Always: `$form['#cache']['tags'][] = 'config:accessible_form_validation.settings';` so the toggles
  invalidate cached forms.

If neither branch sets `errorMessageSelector`, the JS falls back to the class
`form-item--error-message`. Note the double-dash JS/default value vs. the double-underscore
`form-item__error-message` used for Claro/Gin — the form-field description in the settings form also
cites `form-item--error-message` as "the default".

## Reading the values in code

```php
$config = \Drupal::config('accessible_form_validation.settings');
$config->get('default_theme_enabled');                  // bool
$config->get('admin_theme_enabled');                    // bool
$config->get('default_theme_error_message_selector');   // string, may be ''
```

Notes:

- The custom-selector textfield is only shown (`#states` visible) when `default_theme_enabled` is
  checked.
- There is no per-form or per-route targeting: enablement is purely by which theme (default vs admin)
  is rendering the form, and only forms containing a `required` element get any behaviour at runtime
  (the JS skips forms with no `*:required` fields).
- If the site's default and admin theme are the same theme, both toggles refer to that one theme.
