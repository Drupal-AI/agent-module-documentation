<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scheduled action config entity

Managed at `/admin/structure/registration/schedule` (collection), add form
`entity.registration_scheduled_action.add_form`. Each action is a
`registration_scheduled_action` config entity (`config_export` keys):

| Key | Meaning |
|---|---|
| `id` / `label` | machine name / label |
| `weight` | ordering |
| `status` | enabled/disabled |
| `datetime` | offset mapping: `length` (int), `type` (`minutes`\|`hours`\|`days`\|`months`), `position` (`before`\|`after`) |
| `target_langcode` | limit to registrations in this language |
| `plugin` | id of a core Action plugin of type `registration` implementing `QueryableActionInterface` (e.g. `registration_send_email_action`) |
| `configuration` | plugin configuration (opaque map) |

## Create with drush

```php
$sa = \Drupal::entityTypeManager()->getStorage('registration_scheduled_action')->create([
  'id' => 'pre_event_reminder',
  'label' => 'Pre-event reminder',
  'status' => TRUE,
  'weight' => 0,
  'datetime' => ['length' => 3, 'type' => 'days', 'position' => 'before'],
  'target_langcode' => '',
  'plugin' => 'registration_send_email_action',
  'configuration' => [],
]);
$sa->save();
// read: drush cget registration_scheduled_action.pre_event_reminder
```

## How it runs

`Drupal\registration_scheduled_action\Cron\RegistrationSchedule` runs on every cron: for each enabled
action it computes the target window from `datetime` (e.g. 3 days before), queries the registrations
whose relevant date falls in that window (that is why the plugin must be *queryable*), and executes
the action's plugin against them. The eligible plugins are exactly the `registration`-type Action
plugins implementing `QueryableActionInterface`; the base module's `registration_send_email_action`
is the typical choice.
