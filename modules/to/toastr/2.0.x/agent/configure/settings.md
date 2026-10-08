# Configure Toastr

- Route: `toastr.settings` → `/admin/config/system/toastr` (menu: Configuration → System → "Toastr Messages", link `toastr.settings_form`).
- Permission: `administer toastr`.
- Form: `\Drupal\toastr\Form\ToastrSettingsForm` (extends `ConfigFormBase`, id `toastr_settings`).
- Config object: `toastr.settings` (has `config/schema/toastr.schema.yml`; install defaults in `config/install/toastr.settings.yml`).

The form has no validation; every value is written verbatim to config on submit
(`submitForm()` loops over `defaultSettings()` keys and `$config->set()`s each). Missing
keys fall back to `ToastrSettingsForm::defaultSettings()` at read time, so partial config
is safe.

## Config keys

Every key maps to a toastr.js option consumed by `js/messages.js` (except `toastr_toast_type`, see note).

| Key | Type | Default | Form widget | toastr.js option / effect |
|---|---|---|---|---|
| `toastr_toast_position` | string | `toast-top-right` | select (8 corner/full-width options) | `positionClass` |
| `toastr_toast_type` | string | `info` | select (success/info/warning/error) | **Unused at runtime** — see note |
| `toastr_close_button` | bool | `1` | checkbox | `closeButton` |
| `toastr_progress_bar` | bool | `1` | checkbox | `progressBar` |
| `toastr_show_easing` | string | `swing` | textfield | `showEasing` (jQuery UI easing name) |
| `toastr_hide_easing` | string | `linear` | textfield | `hideEasing` |
| `toastr_show_method` | string | `fadeIn` | textfield | `showMethod` (jQuery method) |
| `toastr_hide_method` | string | `fadeOut` | textfield | `hideMethod` |
| `toastr_newest` | bool | `0` | checkbox | `newestOnTop` |
| `toastr_prevent_duplicate` | bool | `0` | checkbox | `preventDuplicates` |
| `toastr_timeout` | int (ms) | `5000` | number | `timeOut` |
| `toastr_extended_timeout` | int (ms) | `10000` | number | `extendedTimeOut` (after hover) |
| `toastr_show_duration` | int (ms) | `300` | textfield | `showDuration` |
| `toastr_hide_duration` | int (ms) | `1000` | textfield | `hideDuration` |
| `toastr_leave_errors` | bool | `1` | checkbox | keeps non-`status` toasts open — see below |
| `toastr_tap_to_dismiss` | bool | `1` | checkbox | `tapToDismiss` |

Position select values: `toast-top-right`, `toast-bottom-right`, `toast-top-left`,
`toast-bottom-left`, `toast-top-center`, `toast-bottom-center`, `toast-top-full-width`,
`toast-bottom-full-width`.

### `toastr_leave_errors` behaviour (from `js/messages.js`)

When enabled, any message whose Drupal type is **not** `status` (i.e. `warning` and
`error`) gets `timeOut` and `extendedTimeOut` forced to `"0"`, so those toasts stay on
screen until the user closes them; `status` toasts still use `toastr_timeout` /
`toastr_extended_timeout`. When disabled, every toast uses the configured timeouts. So
despite the "error" label it pins both warnings and errors.

### Note: `toastr_toast_type`

The "Default Type" select is stored in config and shown on the form, but `js/messages.js`
never reads it — the displayed toast type is derived from the Drupal message type
(`status`→`success`, `warning`, `error`). Changing it has no runtime effect in this version.

## Set without the UI

Drush:

```bash
drush config:set toastr.settings toastr_toast_position toast-bottom-left -y
drush config:set toastr.settings toastr_timeout 3000 -y
drush config:set toastr.settings toastr_leave_errors 1 -y
```

PHP:

```php
\Drupal::configFactory()->getEditable('toastr.settings')
  ->set('toastr_toast_position', 'toast-bottom-left')
  ->set('toastr_timeout', 3000)
  ->save();
```
