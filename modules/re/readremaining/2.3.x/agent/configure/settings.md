<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure ReadRemaining

- **Admin form:** `/admin/config/system/readremaining` (route `readremaining.read_remaining_settings_form`, permission `administer readremaining`). Also under *Configuration → System*.
- **Config object:** `read_remaining_configuration.settings` (a `config_object`, not an entity).
- The gauge is attached only on **node** pages whose bundle is in `contenttypes`; other pages load nothing.

## Settings keys

| Key | Type | Form default | Meaning |
|---|---|---|---|
| `contenttypes` | sequence of strings | none | Node bundles the gauge is active on (checkboxes of all content types). Empty = gauge never loads. |
| `selector` | string | `body` | DOM selector the reading time is calculated on (e.g. `body`, `.my-wrapper`, `#content`). |
| `look_feel` | string | `dark` | `dark` or `light`; selects the CSS library `readremaining/readremaining.<value>`. |
| `show_gauge_delay` | integer | `1000` | Delay before showing the indicator, in ms. |
| `show_gauge_on_start` | boolean | `false` | Show the gauge initially, before the user scrolls. |
| `time_format` | string (label) | `%mm %ss left` | Template; `%m`/`%s` are replaced with minutes/seconds. |
| `max_time_to_show` | integer | `1200` | Only show if remaining time is below this many seconds. |
| `min_time_to_show` | integer | `10` | Only show if remaining time is above this many seconds. |
| `gauge_container` | string | `''` | Element the gauge appends to; empty = the scrolling element. |
| `insert_position` | string | `prepend` | `prepend` or `append` into the container. |
| `verbose_mode` | boolean | `false` | Enable console logging (testing only). |
| `gauge_wrapper` | string | `''` | Element defining the gauge's visible scope; empty = always visible. |
| `top_offset` | integer | `0` | Distance from the wrapper top to where the gauge starts appearing. |
| `bottom_offset` | integer | `0` | Distance between the box appearance point and the element bottom. |

All keys are written by the settings form's submit; the same values are exposed to the
front end under `drupalSettings.readremaining` (every key except `contenttypes` and
`look_feel`). Set them programmatically with:

```php
\Drupal::configFactory()->getEditable('read_remaining_configuration.settings')
  ->set('contenttypes', ['article' => 'article'])
  ->set('look_feel', 'light')
  ->save();
```

## Library requirement

The front-end needs `aerolab/readremaining.js` at `/libraries/readremaining` (JS
`src/readremaining.jquery.js`, CSS `css/rr_dark.css` / `css/rr_light.css`). Install it via
Composer (`aerolab/readremaining` + `composer/installers`); see the module README for the
`repositories` package definition. Without the library the gauge silently does nothing.
