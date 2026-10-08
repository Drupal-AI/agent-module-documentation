# Configure the Back To Top button

## Settings form

- Route: `back_to_top_settings` → path `/admin/config/user-interface/back_to_top`
  (Admin → Configuration → User interface → Back To Top).
- Permission required: `access back_to_top settings` (the only permission the module defines).
- Form class: `Drupal\back_to_top\Form\BackToTopSettingsForm` (a `ConfigFormBase`).
- All values are stored in the `back_to_top.settings` config object (full schema in
  `config/schema/back_to_top.schema.yml`), so they export/deploy with `drush config:export`
  and can be set with `drush cset back_to_top.settings <key> <value>`.

## Settings keys and defaults

| Key | Type | Default | Meaning |
|---|---|---|---|
| `back_to_top_prevent_on_mobile` | boolean | `false` | Hide the button on mobile/touch screens up to 760px wide (checked client-side via `matchMedia`). |
| `back_to_top_prevent_in_admin` | boolean | `false` | Do not attach on admin routes / node edit pages. |
| `back_to_top_prevent_in_front` | boolean | `false` | Do not attach on the front page. |
| `back_to_top_button_trigger` | float | `100` | Pixels the visitor must scroll before the button fades in. |
| `back_to_top_speed` | float | `1200` | Scroll animation duration in milliseconds. |
| `back_to_top_button_place` | integer | `1` | Screen position, 1–9 (see table below). |
| `back_to_top_button_text` | label | `'Back to top'` | Text shown inside the button (used by both button types). |
| `back_to_top_button_type` | string | `'image'` | `'image'` (PNG-24) or `'text'` (CSS/text button). |
| `back_to_top_bg_color` | string | `'#F7F7F7'` | Text button background color. |
| `back_to_top_border_color` | string | `'#CCCCCC'` | Text button border color. |
| `back_to_top_hover_color` | string | `'#EEEEEE'` | Text button hover background/border color. |
| `back_to_top_text_color` | string | `'#333333'` | Text button text color. |

The four color keys only affect the **text** button and are only emitted as inline CSS when
they differ from the defaults above (see [theming](../theming/theming.md)).

## Placement values (`back_to_top_button_place`)

| Value | Position | Value | Position | Value | Position |
|---|---|---|---|---|---|
| 1 | Bottom right (default) | 4 | Top right | 7 | Mid right |
| 2 | Bottom left | 5 | Top left | 8 | Mid left |
| 3 | Bottom center | 6 | Top center | 9 | Mid center |

## Visibility logic

`hook_page_attachments()` skips attaching the library entirely when
`back_to_top_prevent_in_admin` is on and the current route is an admin route, or when
`back_to_top_prevent_in_front` is on and `path.matcher` reports the front page. The
mobile/touch suppression is enforced in JavaScript, not on the server. There is **no
excluded-paths list** — only the mobile, admin, and front-page toggles (plus the
`back_to_top_admin_prevent` alter, see theming) control where the button appears.
