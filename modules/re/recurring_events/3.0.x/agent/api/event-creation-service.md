# Recurring Events — EventCreationService

Service `recurring_events.event_creation_service` = `Drupal\recurring_events\EventCreationService`
(autowire alias on the class name). This is the engine that turns an `eventseries` into
`eventinstance` entities. It is invoked automatically on series save (`recurring_events.module`), but
you can call it directly.

```php
$svc = \Drupal::service('recurring_events.event_creation_service');
```

## Key public methods (`src/EventCreationService.php`)
| Method | Purpose |
|---|---|
| `checkForFormRecurConfigChanges(EventSeries $event, FormStateInterface $fs)` | Did the recur config change vs the submitted form? |
| `checkForOriginalRecurConfigChanges(EventSeries $event, EventSeries $original)` | Did it change vs the stored original? |
| `convertEntityConfigToArray(EventSeries $event)` | Normalize a series' stored recur config to an array. |
| `convertFormConfigToArray(FormStateInterface $fs)` | Same, from form state. |
| `buildDiffArray(EventSeries $event, ?$fs, ?EventSeries $edited)` | Diff between two recur configs (drives recreation + UI). |
| `calculateEventSeriesDates(EventSeries $event): array` | All occurrence date pairs for a series. |
| `calculateDatesFromConfigArray(array $config, EventSeries $event): array` | Dates from a raw config array. |
| `createInstances(EventSeries $event): array` | Create all `eventinstance` entities for the series. |
| `createEventInstance(EventSeries $event, DrupalDateTime $start, DrupalDateTime $end)` | Create one instance. |
| `clearEventInstances(EventSeries $event)` | Delete the series' existing instances (fires deletion hooks). |
| `configureDefaultInheritances(EventInstance $instance, ?int $series_id)` | Set up field_inheritance on a new instance. |
| `addNewDefaultInheritance(EventInstance $instance, FieldInheritanceInterface $fi)` | Add one inheritance. |
| `getRecurFieldTypes($allow_alter = TRUE)` | The available recur field types (respects `hook_recurring_events_recur_field_types`). |
| `updateInstanceStatus(EventInstance $instance, EventSeries $event)` | Sync published status. |

## Lifecycle (on series save)
1. Compute the new recur config; diff against the original.
2. If dates changed: fire pre-deletion hooks, `clearEventInstances()`, then `createInstances()`
   (which calls the active `event_instance_creator` plugin and applies field inheritance).
3. Many alter/lifecycle hooks fire throughout — see [hooks/hooks.md](../hooks/hooks.md).

Dates honor the series' excluded/included dates and the `enabled_fields` / time settings from
`recurring_events.eventseries.config`.
