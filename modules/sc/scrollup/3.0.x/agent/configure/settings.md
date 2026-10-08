# Configure the scroll-up button

Settings form `\Drupal\scrollup\Form\ScrollupForm` (form id `scrollup_form`, `ConfigFormBase`).
Route `scrollup.form` → `/admin/config/system/scrollup`, permission `administer site configuration`.
All values live in the single config object `scrollup.settings`.

## Config keys

| Config key | Form field (type) | Default | Meaning |
|---|---|---|---|
| `scrollup_themename` | Themes Name — `select` `#multiple` (options = installed themes) | `[<site default theme>]` | Which themes load the button. `scrollup_preprocess_page()` attaches the library only when the active theme is in this list. |
| `scrollup_title` | Scrollup Button Title — `textfield` | `Scroll up` | Button label + `title` attribute text. Passed through `t()` before reaching drupalSettings/JS. Empty → JS falls back to `Scroll to the top of the page.` for the title and empty visible text. |
| `scrollup_window_position` | Window scrollup fadeIn/fadeout position — `number` (required) | `600` | Vertical scroll offset in px past which the button becomes visible (`window.pageYOffset > value`). Stored as string. |
| `scrollup_speed` | Scrollup speed — `number` (required) | `0` | Passed as `duration` to `scrollTo` in JS (non-standard option; actual smoothness comes from `behavior:'smooth'`). Stored as string. |
| `scrollup_position` | Button Position — `select` (`1` = right, `2` = left) | `1` | Horizontal side. In LTR, `1` pins right; RTL or `2` pins left. |
| `scrollup_button_bg_color` | Scrollup button background color — `color` | `#CCCCCC` | Inline `background-color` of the button. |
| `scrollup_button_hover_bg_color` | Scrollup button hover background color — `color` | `#000000` | Inline `background-color` applied on `mouseover`. |

Fields are grouped into three fieldsets (`themename_fieldset`, `scrolling_fieldset`,
`button_fieldset`) but values are flat (no `#tree`). `getThemeName()` builds the theme options from
`theme_handler->listInfo()` (human names keyed by machine name).

## Set via drush

```bash
drush config:set scrollup.settings scrollup_title 'Back to top' -y
drush config:set scrollup.settings scrollup_window_position '300' -y
drush config:set scrollup.settings scrollup_position '2' -y
# Which themes show the button (sequence — set by index):
drush config:set scrollup.settings scrollup_themename.0 'olivero' -y
```

## Set via PHP

```php
\Drupal::configFactory()->getEditable('scrollup.settings')
  ->set('scrollup_title', 'Back to top')
  ->set('scrollup_window_position', '300')
  ->set('scrollup_speed', '0')
  ->set('scrollup_position', '1')
  ->set('scrollup_button_bg_color', '#CCCCCC')
  ->set('scrollup_button_hover_bg_color', '#000000')
  ->set('scrollup_themename', ['olivero'])
  ->save();
```

## Schema

`config/schema/scrollup.schema.yml` defines `scrollup.settings` as `config_object`. Every scalar key
is typed `string`; `scrollup_themename` is a `sequence` of `string`. Defaults are seeded on install
by `scrollup_install()` (there is no `config/install/*.yml`).
