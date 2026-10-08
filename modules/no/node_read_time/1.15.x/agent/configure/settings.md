<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — `node_read_time.settings`

Settings form `ReadingTimeConfigForm` at `/admin/config/reading-time`
(route `system.admin_config_reading_time`). One config object, nested under a `reading_time`
mapping:

| Key | Default | Meaning |
|---|---|---|
| `reading_time.container.<type>.is_activated` | (unset) | `1` to enable reading time for node type `<type>`, else `0`/unset. |
| `reading_time.words_per_minute` | `225` | Reading rate; when empty the code falls back to 225. |
| `reading_time.unit_of_time` | `minute` | Output format (see below). |

`unit_of_time` values:
- `minute` — whole minutes, e.g. "3 minutes".
- `second` — minutes + seconds, e.g. "2 minutes, 30 seconds".
- `below` — minutes + seconds, but "1 minute" when the text is under one minute's worth.
- `default` — a bare rounded-up minute number (no unit text).

## Displaying the value

Activating a type registers an **extra field** `reading_time` (via
`hook_entity_extra_field_info`). Turn it on where you want it on the node's *Manage display*
page (`/admin/structure/types/manage/<type>/display`) — it is hidden by default. In a custom
template render it with `{{ content.reading_time }}`. There is also a computed base field
`node_read_time` and a Views field "Node read time" for other placements.

## Drush / config recipes

```bash
# Read the whole config:
drush config:get node_read_time.settings

# Set the reading rate to 200 wpm and format as minutes + seconds:
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("node_read_time.settings");
  $c->set("reading_time.words_per_minute", 200)
    ->set("reading_time.unit_of_time", "second")->save();
'

# Enable reading time for the Article content type:
drush php:eval '
  \Drupal::configFactory()->getEditable("node_read_time.settings")
    ->set("reading_time.container.article.is_activated", 1)->save();
'
```

Note: `reading_time.container` is a sequence keyed by content-type machine name; each entry is
a mapping with the single integer key `is_activated`. Setting the config alone activates the
calculation and the extra field; you still position the field on Manage display to show it.
