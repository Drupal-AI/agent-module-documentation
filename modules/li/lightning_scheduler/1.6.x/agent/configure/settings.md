<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, storage & cron processing

## Settings

Config object **`lightning_scheduler.settings`** (form `SettingsForm`, route
`lightning_scheduler.settings` at `/admin/config/system/lightning/scheduler`, permission
`administer lightning scheduler`; menu link parent `system.admin_config_content`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `time_step` | int | `60` | The scheduling time input's HTML `step`, in **seconds**. Allowed by the form: `1`, `60`, `300`, `600`, `900`, `1800`, `3600` (1 sec … 1 hour). |
| `allow_past_dates` | bool | `true` | Whether an author may schedule a transition for a date/time in the past. When false, validation rejects past dates. |

```bash
drush cget lightning_scheduler.settings
drush cset lightning_scheduler.settings time_step 900 -y
drush cset lightning_scheduler.settings allow_past_dates 0 -y
```

`SettingsForm::submitForm()` casts `time_step` to int on save.

## How a schedule is stored

For each moderated entity type the module installs two base fields (`BaseFields`), both
revisionable, translatable, unlimited cardinality:

- `scheduled_transition_date` — `datetime` field; each delta is one transition's date/time.
- `scheduled_transition_state` — `string` field; each delta is the target workflow state id.

The two fields are **parallel** (delta *i* of date pairs with delta *i* of state). Internally
this is a `TransitionSet` — conceptually a sorted list of `{state, when}` (JSON, times in UTC
ISO-8601). The moderation-state edit widget is replaced with `ModerationStateWidget`, which
adds JS to queue "on DATE → STATE" entries; its hidden value is validated by
`TransitionManager::validate()` (rejects malformed data, non-numeric timestamps, out-of-order
entries, and — unless `allow_past_dates` — past times).

## Cron execution

`hook_cron` (`lightning_scheduler_cron`) runs `TransitionManager::process()` for every entity
type that has both scheduling fields. For each entity whose earliest pending transition is due
(query looks back only ~3 days before the last successful cron, for performance):

1. compute the expected target state for "now" (`TransitionSet::getExpectedState`),
2. if the workflow defines a transition from the current `moderation_state` to that target,
   set `moderation_state` and save; otherwise **log a warning** and skip (it never forces an
   illegal transition),
3. trim elapsed entries from the set.

Run it manually in tests with `drush cron`.

## Setting a schedule from code

```php
// $node is a moderated entity. Schedule: on $ts, go to 'published'.
$utc = \Drupal\datetime\Plugin\Field\FieldType\DateTimeItemInterface::DATETIME_STORAGE_FORMAT;
$tz  = \Drupal\datetime\Plugin\Field\FieldType\DateTimeItemInterface::STORAGE_TIMEZONE;
$when = \Drupal\Core\Datetime\DrupalDateTime::createFromTimestamp($ts, $tz)->format($utc);
$node->set('scheduled_transition_date', [$when]);
$node->set('scheduled_transition_state', ['published']);
$node->save();
```

(The fields only exist when the entity type is under a Content Moderation workflow.)
