<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the FullCalendar block

There is **no admin settings form** (`configure: null`). You place the block plugin `fullcalendar_block`
via Block layout (`/admin/structure/block`, "Place block" → search "FullCalendar block") and configure it
on the block's own form. Settings persist inside the **`block.block.<id>`** config entity under `settings`.

## Settings (schema `block.settings.fullcalendar_block`) + defaults

| Key | Default | Meaning |
|---|---|---|
| `event_source` | `''` (**required** on the form) | JSON event-feed URL — relative (`/event-feed`, e.g. a View REST export) or absolute. |
| `use_token` | `false` | Replace tokens in `event_source` (needs the `token` module for the picker). |
| `initial_view` | `dayGridMonth` | Starting view, e.g. `timeGridWeek`, `timeGridDay`, `listMonth`. |
| `header_start` | `prev,next today` | Left toolbar segment. |
| `header_center` | `title` | Center toolbar segment. |
| `header_end` | `dayGridMonth,timeGridWeek,timeGridDay,listMonth` | Right toolbar (view switcher). |
| `open_dialog` | `1` | Event click: `0` new tab, `1` dialog, `2` current tab. |
| `dialog_width` | `800` | Dialog width when `open_dialog = 1`. |
| `plugins` | `[]` | Enable FullCalendar plugins: `moment`, `rrule`. |
| `advanced` | `''` | Free-form YAML/JSON merged into the FullCalendar options (e.g. `initialDate: '2022-05-01'`). |
| `advanced_drupal` | `''` | Free-form YAML/JSON for dialog/description-popup/draggable/resizable/event-background behaviour. |

`build()` also injects `firstDay` (from `system.date`), text direction, and locale from Drupal.

## Place & configure via drush (scriptable)

```php
// Create a FullCalendar block instance in the default theme's content region.
$theme = \Drupal::config('system.theme')->get('default');
\Drupal\block\Entity\Block::create([
  'id' => 'my_calendar',
  'theme' => $theme,
  'region' => 'content',
  'weight' => 0,
  'plugin' => 'fullcalendar_block',
  'settings' => [
    'id' => 'fullcalendar_block',
    'label' => 'Events',
    'label_display' => '0',
    'event_source' => '/event-feed',
    'initial_view' => 'dayGridMonth',
    'plugins' => ['rrule'],
  ],
  'visibility' => [],
])->save();
```

Read a placed block's settings:

```bash
drush config:get block.block.my_calendar settings
drush config:get block.block.my_calendar settings.event_source
```

The `advanced` / `advanced_drupal` values must be valid YAML/JSON (a form validator enforces this); see
[hooks/alter.md](../hooks/alter.md) for the `advanced_drupal` options (dialog_type, description_popup,
draggable, resizable, event_background, html_title, …).
