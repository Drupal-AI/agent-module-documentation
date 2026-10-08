# Configure the scroll-to-top button

Everything is a single config object, `scroll_top_button.settings`. Form:
`/admin/config/user-interface/scroll_top_button` (route `scroll_top_button.settings`,
`ScrollTopButtonSettingsForm`, requires core permission **`administer site configuration`**).
The module defines **no permissions** of its own.

## Config keys (shipped defaults from `config/install`)

| Key | Type | Default | Notes |
|---|---|---|---|
| `enabled` | **string** | `'off'` | `'on'` or `'off'` — a radios element, **not** a boolean. The `hook_page_attachments` check is `== 'on'`. |
| `show_on_admin` | boolean | `FALSE` | If FALSE the button is suppressed on admin routes (`router.admin_context`). |
| `button_text` | string | `'Scroll to top'` | Label shown on the button. |
| `button_style` | string | `'image'` | One of `image`, `link`, `pill`, `tab`. |
| `button_animation` | string | `'fade'` | One of `fade`, `slide`, `none`. |
| `button_animation_speed` | integer | `200` | Reveal animation duration (ms). |
| `scroll_distance` | integer | `100` | Pixels the user must scroll before the button appears. |
| `scroll_speed` | integer | `300` | Duration of the scroll-to-top animation (ms). |

## How it is applied

`scroll_top_button_page_attachments()` runs on every page: if `enabled == 'on'` (and the page is
not an admin route with `show_on_admin` false) it attaches the
`scroll_top_button/scroll_top_button` library and passes all the above values (except `enabled`/
`show_on_admin`) into `drupalSettings`. The bundled jQuery (`js/scroll.top.button.js`) uses them to
show/hide and animate the button. No cache rebuild is needed for a config change to take effect on
the next request.

## Set it with drush

```bash
drush cset scroll_top_button.settings enabled on -y
drush cset scroll_top_button.settings button_style pill -y
drush cset scroll_top_button.settings scroll_distance 250 -y
drush cget scroll_top_button.settings          # read the whole object back
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('scroll_top_button.settings')
  ->set('enabled', 'on')->set('button_style', 'tab')->save();
```

## Gotchas

- `enabled` is `'on'`/`'off'` (string). Setting it to boolean `TRUE` will **not** turn the button
  on — the runtime check is a strict `== 'on'`.
- The button is front-end only and applies to the active theme site-wide; there is no per-page or
  per-block control.
