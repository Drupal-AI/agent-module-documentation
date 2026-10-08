# Site Alert services & entity API

## `site_alert.get_alerts` — `Drupal\site_alert\GetAlerts`

Interface `GetAlertsInterface`. Reads currently-active alerts:

```php
$svc = \Drupal::service('site_alert.get_alerts');
$ids = $svc->getActiveAlertIds();     // array of entity IDs active right now
$alerts = $svc->getActiveAlerts();    // loaded SiteAlert entities (or [])
```

"Active now" = `active == 1` AND (`scheduling.value` ≤ now OR unset) AND (`scheduling.end_value` > now
OR unset). Times are compared in UTC storage format. The query uses `accessCheck(FALSE)` (alerts are
public by design).

## `SiteAlert` entity (`site_alert` content entity)

Create/read alerts directly through entity storage:

```php
$storage = \Drupal::entityTypeManager()->getStorage('site_alert');
$alert = $storage->create([
  'label' => 'deploy',
  'active' => TRUE,
  'severity' => 'high',                 // low | medium | high
  'message' => 'Deploying now.',
  'scheduling' => ['value' => '2026-08-10T15:00:00', 'end_value' => '2026-08-10T17:00:00'],
]);
$storage->save($alert);
```

Getter helpers on the entity: `getActive()`, `getSeverity()`, `getLabel()`, `getMessage()`,
`getStartTime()` / `getEndTime()` (formatted in the site timezone), and `isCurrentlyScheduled()`.
`SiteAlert::SEVERITY_OPTIONS` = `['low'=>'Low','medium'=>'Medium','high'=>'High']`.

## `CliCommands` — `site_alert.cli_commands`

The shared service behind the Drush commands (`create`, `delete`, `enable`, `disable`,
`validateCreateInput`). Reuse it from custom code to perform the same label-based operations with
validation.

## Cache context

`cache_context.active_site_alerts` (id `active_site_alerts`) varies rendered output by which alerts are
currently active — add it to `#cache['contexts']` on anything whose output depends on live alerts. The
`SiteAlertStorage::getCacheMaxAge()` returns the seconds until the next scheduled alert boundary, used to
set response max-age.
