# Recurring Events — hooks

Source: `recurring_events.api.php`. Two groups: **option alters** (change what the creation form
offers / what gets created) and **lifecycle hooks** (run code around instance deletion/creation).

## Option / data alters
| Hook | Alters |
|---|---|
| `hook_recurring_events_times_alter(array &$times)` | Selectable start times (`h:i a`). |
| `hook_recurring_events_durations_alter(array &$durations)` | Duration options (seconds ⇒ label). |
| `hook_recurring_events_units_alter(array &$units)` | Recurrence unit options. |
| `hook_recurring_events_days_alter(array &$days)` | Days of week available. |
| `hook_recurring_events_month_days_alter(array &$month_days)` | Days-of-month available. |
| `hook_recurring_events_recur_field_types(&$fields)` | Which recur field types are offered. |
| `hook_recurring_events_event_instance_alter(array &$event_instance)` | A single instance's data before save. |
| `hook_recurring_events_event_instances_pre_create_alter(&$event_instances, EventSeries $event)` | The whole array of instances before creation (drop/adjust occurrences). |
| `hook_recurring_events_form_config_array_alter(array &$form_config)` | Recur config parsed from the form. |
| `hook_recurring_events_entity_config_array_alter(array &$entity_config)` | Recur config parsed from the entity. |
| `hook_recurring_events_diff_array_alter(array &$diff)` | The computed recur-config diff. |
| `hook_recurring_events_event_instance_creator_plugin_alter(EventInstanceCreatorInterface &$active_plugin, EventInstanceCreatorPluginManager $manager, EventSeries $series)` | Swap the active creator plugin per series. |
| `hook_recurring_events_save_pre_instances_deletion_alter(array &$instances)` | Filter which existing instances get deleted on a recur change (e.g. keep published ones). |

## Lifecycle hooks (recur-config-change driven)
Fired by `EventCreationService` when a series' dates change and instances are recreated:
- `hook_recurring_events_save_pre_instances_deletion(EventSeries $series)` / `..._post_instances_deletion(...)`
- `hook_recurring_events_save_pre_instance_deletion(EventSeries $series, EventInstance $instance)` /
  `..._post_instance_deletion(...)`

## Lifecycle hooks (direct deletion driven)
Fired when instances are deleted by deleting the series/instance directly (not via a recur change):
- `hook_recurring_events_pre_delete_instances(EventSeries $series)` / `..._post_delete_instances(...)`
- `hook_recurring_events_pre_delete_instance(EventInstance $instance)` / `..._post_delete_instance(...)`

Example — skip creating events on blackout dates:
```php
function mymodule_recurring_events_event_instances_pre_create_alter(&$event_instances, \Drupal\recurring_events\Entity\EventSeries $event) {
  $blackout = ['2026-07-01', '2026-07-02'];
  foreach ($event_instances as $k => $i) {
    if (in_array($i['start_date']->format('Y-m-d'), $blackout, TRUE)) {
      unset($event_instances[$k]);
    }
  }
}
```
