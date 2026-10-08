# Hooks & events (office_hours.api.php)

## Alter hooks
```php
/**
 * Alter the "current time" used to compute current/open status.
 * Use case: shift to the content owner's timezone.
 */
function hook_office_hours_current_time_alter(int &$time, $entity) {
  // $time is a UNIX timestamp; $entity is the displayed entity.
}

/**
 * Alter a formatted time string before display (e.g. "09:00-17:00").
 */
function hook_office_hours_time_format_alter(string &$formatted_time) {
  // e.g. str_replace('12a.m.-12a.m.', 'All day open', $formatted_time);
}
```

## Event subscriber
The module ships a commented-out `office_hours_subscriber.default` in
`office_hours.services.yml`. To react to office-hours events, copy that service definition into
your module and subclass `Drupal\office_hours\EventSubscriber\OfficeHoursEventSubscriber`,
tagging it `event_subscriber`.

Hook implementations themselves live in OOP form under `src/Hook/` (`OfficeHoursHooks`,
`OfficeHoursFieldHooks`, `OfficeHoursThemeHooks`, `OfficeHoursViewsHooks`).
