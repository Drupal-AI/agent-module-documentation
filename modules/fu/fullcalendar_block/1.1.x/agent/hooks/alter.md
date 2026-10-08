<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_fullcalendar_block_settings_alter()` + JS events

## PHP alter hook (`fullcalendar_block.api.php`)

```php
function hook_fullcalendar_block_settings_alter(array &$block_settings, array &$block_content, \Drupal\Core\Block\BlockPluginInterface $block) {
  // $block_settings has: 'calendar_options' (the FullCalendar options array),
  //   'dialog_open', 'dialog_width', and 'advanced' (the decoded advanced_drupal).
  if ($block->getPluginId() === 'fullcalendar_block') {
    // Add multiple event sources:
    $block_settings['calendar_options']['events'] = [
      $block_settings['calendar_options']['events'],
      '/alternative-event-source-2',
    ];
    // Enable description popups by default:
    $block_settings['advanced']['description_popup'] = TRUE;
    $block_settings['advanced']['description_field'] = 'des';
  }
}
```

Invoked in `FullCalendarBlock::build()` via `$this->moduleHandler->alter('fullcalendar_block_settings', …)`
before the settings are handed to `drupalSettings`.

### `advanced_drupal` / `$block_settings['advanced']` keys

`dialog_type`, `dialog_options`, `draggable` (+ `draggable_options`), `resizable` (+ `resizable_options`),
`description_popup`, `description_field` (default `des`), `html_title`, `raw_title_field` (default
`rawTitle`), and `event_background` (`field_name` + `color_map`). Enabling `description_popup` attaches
DOMPurify; `draggable`/`resizable` attach the jQuery UI libraries when those modules exist.

## JavaScript events

- `fullcalendar_block.beforebuild` — dispatched before a calendar is built; detail includes
  `calendarOptions`.
- `fullcalendar_block.build` — dispatched after build; detail `blockInstance` has `element`, `index`,
  `calendar` (the FullCalendar instance), `calendarOptions`, `blockSettings`.

## Dev mode

`$settings['fullcalendar_block.dev_mode'] = TRUE;` in `settings.php` (then clear cache) switches the loaded
assets to their non-minified versions (`hook_library_info_alter`).
