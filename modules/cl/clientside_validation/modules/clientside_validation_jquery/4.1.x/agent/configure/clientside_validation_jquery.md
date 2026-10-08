# Configure the jQuery engine

## Settings form

- **Path:** `/admin/config/user-interface/clientside-validation-jquery-settings`
- **Route:** `clientside_validation_jquery.settings_form`
- **Permission:** `administer site configuration`
- **Config object:** `clientside_validation_jquery.settings` (has schema; export/deploy with `drush config:export`)
- Form class: `ClientsideValidationjQuerySettingsForm`

## Settings keys (defaults from `config/install`)

| Key | Default | Meaning |
|---|---|---|
| `use_cdn` | `false` | Load jQuery Validate from CDN instead of a local library |
| `cdn_base_url` | `https://cdn.jsdelivr.net/npm/jquery-validation@1.21.0/dist/` | CDN base (include the trailing slash + version) |
| `validate_all_ajax_forms` | `2` | Validate AJAX forms before submit; forms with class `cv-validate-before-ajax` are validated |
| `force_validate_on_blur` | `0` | Force validation on blur/focusout |
| `force_html5_validation` | `false` | Run native HTML5 validation first, before the jQuery layer |

Set via drush, e.g. `drush cset clientside_validation_jquery.settings use_cdn 1`.

## Library resolution (how the JS is found)

`hook_library_info_alter()` picks the jQuery Validate source in this order:

1. Local library at `/libraries/jquery-validation/dist/jquery.validate.min.js` (used if present and `use_cdn` is off).
2. A copy shipped inside the module (`js/lib/` or `js/lib/dist/`) — legacy extraction locations.
3. Otherwise (or when `use_cdn` is true) the CDN at `cdn_base_url`.

To install a local copy, use the Drush commands
([drush/clientside_validation_jquery.md](../drush/clientside_validation_jquery.md)) or place the
library manually under `/libraries/jquery-validation/dist/`.

## Values pushed to the browser

`hook_page_attachments()` puts `validate_all_ajax_forms`, `force_validate_on_blur`,
`force_html5_validation` and a set of default translated messages under
`drupalSettings.clientside_validation_jquery`, tagged with the config's cache tags.
