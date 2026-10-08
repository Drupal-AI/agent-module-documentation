<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Time" (`number_time`) field formatter

## Where to use it

On any `integer`, `decimal` or `float` field, set its display format to **"Time"** on the
bundle's *Manage display* page (`/admin/structure/types/manage/<bundle>/display`), or set the
component `type: number_time` in the `entity_view_display` config.

## Settings

Config schema `field.formatter.settings.number_time` (all integers):

| Setting | Values | Default | Meaning |
|---|---|---|---|
| `storage` | `0` = Seconds, `1` = Milliseconds | `1` (Milliseconds) | How to interpret the stored number. Seconds are multiplied by 1000 internally. |
| `display` | `0` = `123h 59m 59s 999ms`, `1` = `123h 59m 59s`, `2` = `123:59:59.999`, `3` = `123:59:59` | `2` | Output format. `0`/`2` include milliseconds; `1`/`3` drop them. |
| `hours` | `0` = Always, `1` = Optional, `2` = Never | `0` (Always) | Whether to show the hours component. Optional shows it only when hours > 0; Never rolls all hours into minutes. |

## Output examples

- storage=Milliseconds, display=`123:59:59.999`, value `3661999` → `1:01:01.999`
- storage=Seconds, display=`123h 59m 59s`, value `3661` → `1h 1m 1s`
- hours=Never, display=`123:59:59`, value `65000` ms → `1:05`

The value is `round()`-ed to whole milliseconds, then split into ms/s/m/h. With
hours=Optional the leading hours segment is omitted when hours is 0.

## Apply via API

```php
$vd = \Drupal::service('entity_display.repository')->getViewDisplay('node', 'article', 'default');
$vd->setComponent('field_duration', [
  'type' => 'number_time',
  'label' => 'above',
  'settings' => ['storage' => 0, 'display' => 1, 'hours' => 1], // seconds, "123h 59m 59s", optional hours
])->save();
```

Read it back:

```bash
drush cget core.entity_view_display.node.article.default content.field_duration
# type: number_time; settings.storage / settings.display / settings.hours
```
