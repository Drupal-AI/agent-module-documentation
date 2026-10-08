<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up the TwentyTwenty formatter

## 1. Install module + library

```bash
composer require drupal/zurb_twentytwenty
drush en zurb_twentytwenty -y

# The plugin itself is NOT a composer package — fetch it manually:
mkdir -p web/libraries
curl -L https://github.com/zurb/twentytwenty/archive/refs/heads/master.tar.gz | tar xz
mv twentytwenty-master web/libraries/twentytwenty

# Confirm the requirement check is happy:
drush status-report --severity=2 | grep -i twentytwenty || echo "library OK"
```

Expected files: `/libraries/twentytwenty/css/twentytwenty.css`,
`/libraries/twentytwenty/js/jquery.event.move.js`,
`/libraries/twentytwenty/js/jquery.twentytwenty.js`.

## 2. Field must hold two images

```bash
# Cardinality 2 on an existing image field:
drush cset field.storage.node.field_comparison cardinality 2 -y
```

Cardinality is a *storage* setting; the formatter only warns about it in its summary.

## 3. Point the display at the formatter

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_comparison.type twentytwenty_field_formatter -y
drush cset core.entity_view_display.node.article.default \
  content.field_comparison.settings.before_label 'Before' -y
drush cr
```

Or in the UI: *Structure → Content types → … → Manage display*, set the image field's format to
**TwentyTwenty**, then open the gear icon for the settings below.

## 4. Settings reference

| Setting | Default | Type | Effect |
|---|---|---|---|
| `image_style` | `''` (original) | select | Image style applied to both images |
| `default_offset_pct` | `'0.5'` | textfield | Handle start position, 0–1 (0.5 = centered) |
| `orientation` | `'horizontal'` | textfield | `horizontal` or `vertical` — free text, not validated |
| `before_label` | `'Before'` | textfield | Overlay label for the first image |
| `after_label` | `'After'` | textfield | Overlay label for the second image |
| `no_overlay` | `false` | checkbox | Hide the hover overlay + labels |
| `move_slider_on_hover` | `false` | checkbox | Slider follows the pointer without dragging |
| `move_with_handle_only` | `true` | checkbox | Only the handle drags the divider |
| `click_to_move` | `false` | checkbox | Click anywhere to move the divider (useful on touch) |

A full display-config fragment:

```yaml
# core.entity_view_display.node.article.default
content:
  field_comparison:
    type: twentytwenty_field_formatter
    label: hidden
    settings:
      image_style: large
      default_offset_pct: '0.5'
      orientation: horizontal
      before_label: Before
      after_label: After
      no_overlay: false
      move_slider_on_hover: false
      move_with_handle_only: true
      click_to_move: true
    third_party_settings: {}
```

Note there is **no config schema** shipped for these settings (`provides_config_schema: false`),
so `drush config:inspect`-style schema checks will flag the display config; the settings still
save and apply.

## Troubleshooting

| Symptom | Cause |
|---|---|
| Both images render stacked, no slider | Library missing at `/libraries/twentytwenty/` — check the status report |
| Only one image, no comparison | Field has a single value; the plugin needs two |
| Second field on the page ignores its settings | Global `drupalSettings.twentytwenty` — see [theming/markup.md](../theming/markup.md) |
| Slider is full-width but images differ in size | Set an `image_style` so both render at identical dimensions |
