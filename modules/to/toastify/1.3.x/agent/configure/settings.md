# Configure Toastify

**Config object:** `toastify.settings` · **Form route:** `toastify.settings_form`
(`/admin/config/user-interface/toastify`, permission `administer toastify configuration`).

## Structure

`status`, `warning` and `error` are three identical maps (one per Drupal message type). Each
holds:

| Key | Type | Default (status/warning/error) | Meaning |
|---|---|---|---|
| `duration` | int (ms) | 5000 | Time before auto-dismiss |
| `gravity` | string | `top` | `top` or `bottom` |
| `position` | string | `right` | `left`, `right` or `center` |
| `offsetX` | int | 0 | Horizontal offset from the side |
| `offsetY` | int | 0 | Vertical offset from top/bottom |
| `close` | bool | false | Show a manual close (×) button |
| `color` | string (hex) | `#67b99a` / `#ffaa00` / `#e01e37` | Gradient start color |
| `color2` | string (hex) | `#14746f` / `#ff6d00` / `#a71e34` | Gradient end color |
| `colorProgressBar` | string (hex) | `#0d514d` / `#b24c00` / `#741424` | Progress-bar color |
| `direction` | string | `to right` | CSS gradient direction |

Top-level `enable_for` map:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enable_for.admin_theme` | bool | true | Show toasts when the active theme is the admin theme |
| `enable_for.frontend_theme` | bool | true | Show toasts on the frontend theme |

`toastify_is_active()` returns TRUE only when the current user has `show toastify messages`
**and** the matching `enable_for` toggle for the current route's theme is on. When Gin (or a
Gin sub-theme) is active the color/direction fields are hidden and a Gin stylesheet
(`toastify/gin`) is loaded instead; the stored color values are then ignored.

## Read / set via drush

```bash
drush cget toastify.settings status.duration          # read one value
drush cget toastify.settings enable_for
drush cset toastify.settings status.duration 10000 -y  # set one value
drush cset toastify.settings enable_for.frontend_theme false -y
```

Note the form saves values under nested keys (`status.duration`, `error.position`, …); the
form field names use underscores (`status_duration`) but the stored config uses dot paths.

## Via PHP

```php
\Drupal::configFactory()->getEditable('toastify.settings')
  ->set('warning.close', TRUE)
  ->set('warning.duration', 8000)
  ->save();
```
