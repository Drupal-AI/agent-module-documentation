<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service: default-content date adjustment

The module registers exactly one service:

```yaml
# acquia_cms_event.services.yml
acquia_cms_event.default_content_event_update:
  class: Drupal\acquia_cms_event\DefaultContentEventUpdate
```

`Drupal\acquia_cms_event\DefaultContentEventUpdate` exists so that the sample/demo Event nodes shipped
by the Acquia CMS starter content don't import with stale, already-past dates. It has no injected
dependencies and is invoked by the starter-content import flow, not on normal requests.

## Methods

| Method | Signature | Behavior |
|--------|-----------|----------|
| `getUpdatedDates` | `getUpdatedDates(array $date_time): array` | If `start_date` is within 2 days of now, moves it to now + 30 days and (if present) `end_date` to the new start + 1 day. Sets `door_time` equal to `start_date`. Returns the adjusted array. |
| `updateEventNode` | `updateEventNode(NodeInterface $entity, array $updated_data): void` | Writes the adjusted dates back onto a node: rewrites `field_event_start`, `field_event_end`, `field_door_time` (preserving each field's original time-of-day), recomputes `field_event_duration` as a human string ("%a days, %h hours, %i minutes") via `date_diff`, and calls `$entity->save()`. |

## Usage

```php
$updater = \Drupal::service('acquia_cms_event.default_content_event_update');
$dates = $updater->getUpdatedDates([
  'start_date' => '2021-01-01',
  'end_date'   => '2021-01-02',
]);
// $dates now has future start/end and a matching door_time.
$updater->updateEventNode($eventNode, $dates);
```

Notes for integrators: the input array uses the keys `start_date`, `end_date`, `door_time`; dates are
parsed with `strtotime()`/`\DateTime` and formatted back with the node fields' own times. This is a
convenience for seeding demo content — it is not a general scheduling API and does nothing at runtime.
