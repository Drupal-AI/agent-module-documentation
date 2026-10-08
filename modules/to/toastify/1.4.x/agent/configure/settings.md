<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Toastify

**Config object:** `toastify.settings` · **Form:** `Drupal\toastify\Form\SettingsForm`
(route `toastify.settings_form`, `/admin/config/user-interface/toastify`, permission
`administer toastify configuration`). Defaults ship in `config/install/toastify.settings.yml`;
schema in `config/schema/toastify.schema.yml` (types `toastify.settings` → `config_object`,
per-type map `toastify_type_settings`).

## Structure

`status`, `warning` and `error` are three identical maps (one per Drupal message type). Each
holds:

| Key | Type | Default (status/warning/error) | Meaning |
|---|---|---|---|
| `duration` | int (ms) | 5000 | Time before auto-dismiss (`#min` 0, required) |
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

`toastify_is_active()` (in `toastify.module`) returns TRUE only when the request is **not** an
XmlHttpRequest, the current user has `show toastify messages`, **and** the matching `enable_for`
toggle for the active theme (admin vs. default) is on. When Gin (or a Gin sub-theme) is active
— detected by `_toastify_is_gin_theme_active()` — the color/direction fields are hidden and the
`toastify/gin` stylesheet is loaded instead; the stored color values are then ignored.

The settings form uses the `jquery_colorpicker` element for color fields when that module is
installed, otherwise the HTML5 `color` element. Submitting the form runs `Xss::filter()` on the
gradient `direction` value and then adds one example status, warning and error message so the
admin can preview the toasts.

## Read / set via drush

```bash
drush cget toastify.settings status.duration          # read one value
drush cget toastify.settings enable_for
drush cset toastify.settings status.duration 10000 -y  # set one value
drush cset toastify.settings enable_for.frontend_theme false -y
```

Note the stored config uses nested dot paths (`status.duration`, `error.position`, …), while
the form field names use underscores (`status_duration`).

## Via PHP

```php
\Drupal::configFactory()->getEditable('toastify.settings')
  ->set('warning.close', TRUE)
  ->set('warning.duration', 8000)
  ->save();
```

## Install-time migrations (`toastify.install`)

- `toastify_update_8001` — converts the old `positionLeft` boolean into the `position`
  string (`left`/`right`).
- `toastify_update_8002` — seeds `offsetX`/`offsetY` defaults (0).
- `toastify_update_8003` — seeds `enable_for.admin_theme`/`enable_for.frontend_theme` (TRUE).
