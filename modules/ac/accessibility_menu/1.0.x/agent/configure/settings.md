# Configure the accessibility menu

Settings form `Drupal\accessibility_menu\Form\AccessibilityMenuSettingsForm` (form id
`accessibility_menu_settings_form`), a `ConfigFormBase` editing the single config object
`accessibility_menu.settings`.

- Route: `accessibility_menu.settings` → `/admin/config/development/accessibility-menu`
- Permission: `administer site configuration` (core; the module defines no permission of its own)
- Menu link: `accessibility_menu.settings` under `system.admin_config_development`

## Config keys (`accessibility_menu.settings`)

| Key | Type | Default | Effect |
| --- | --- | --- | --- |
| `enabled` | bool | `1` | When true, `hook_preprocess_html` auto-injects the widget into `page_bottom` (see below). |
| `inline` | bool | `1` | When true the block inlines `misc/accessibility_menu.js` into a `<head>` `<script>`; when false it attaches the `accessibility_menu/js` library instead. |
| `show_mobile` | bool | `0` | When true the template adds `am-mobile-visible` and the widget is shown below 1200px; otherwise it is hidden on small screens by CSS. |
| `plugins` | map | all except `cursor`/`reading_line` | Which features appear in the panel. Checkboxes; each key is `'<name>'` when on or `0` when off. |

`plugins` sub-keys (feature toggles — these are NOT Drupal plugins, just on/off flags read by the
block): `contrast`, `font_size`, `letter_spacing`, `line_height`, `images`, `font_style`, `cursor`,
`reading_line`. Install default enables the first six; `cursor` and `reading_line` are off.

The form nests everything under a `fields` tree; `submitForm()` writes each `fields` value straight
onto `accessibility_menu.settings`.

## How the widget reaches the page

Two independent paths — you can use either or both:

1. **Auto-inject (config `enabled`).** `accessibility_menu_preprocess_html()` checks
   `accessibility_menu.settings:enabled`; if set AND the active theme equals `system.theme:default`
   (i.e. the front-end default theme, not the admin theme), it creates the `accessibility_menu`
   block instance and renders it into `$vars['page_bottom']`. No block placement needed.
2. **Manual block placement.** Place the "Accessibility menu" block (id `accessibility_menu`) in any
   region via Block Layout — see [../blocks/accessibility_menu.md](../blocks/accessibility_menu.md).

## Set values without the UI

Drush:

```bash
# Enable the widget site-wide, inline the JS, keep it hidden on mobile
drush config:set accessibility_menu.settings enabled 1 -y
drush config:set accessibility_menu.settings inline 1 -y
drush config:set accessibility_menu.settings show_mobile 0 -y
# Toggle a feature (turn the reading line on)
drush config:set accessibility_menu.settings plugins.reading_line reading_line -y
# Turn a feature off
drush config:set accessibility_menu.settings plugins.cursor 0 -y
```

PHP:

```php
\Drupal::configFactory()->getEditable('accessibility_menu.settings')
  ->set('enabled', 1)
  ->set('inline', 1)
  ->set('show_mobile', 0)
  ->set('plugins', [
    'contrast' => 'contrast',
    'font_size' => 'font_size',
    'letter_spacing' => 'letter_spacing',
    'line_height' => 'line_height',
    'images' => 'images',
    'font_style' => 'font_style',
    'cursor' => 0,
    'reading_line' => 0,
  ])
  ->save();
```

## Notes

- **No config schema.** The module ships `config/install/accessibility_menu.settings.yml` but no
  `config/schema/*.yml`, so these keys have no typed-data schema (config-inspector/translation will
  warn). Defaults are also backfilled by `hook_update_N`: `accessibility_menu_update_10001` seeds
  `inline` + `plugins`, `accessibility_menu_update_10002` seeds `show_mobile`.
- The block adds the config object as a cacheable dependency, so saved settings invalidate the
  rendered block automatically.
