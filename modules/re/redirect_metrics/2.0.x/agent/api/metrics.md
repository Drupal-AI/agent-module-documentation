# Redirect metrics — fields & counting mechanism

## Base fields added to the `redirect` entity
Added by `redirect_metrics_entity_base_field_info()` (via
`RedirectMetricsFieldDefinitions::getAll()`):

| Field | Type | Notes |
|---|---|---|
| `access_count` | integer | Required; initial value `0` (`setInitialValue(0)`). Number of times the redirect was used. |
| `last_access` | timestamp | Required. Last time the redirect was hit. Provider `redirect_metrics`. |

They are real entity base fields (no custom SQL table), so they are queryable, Views-exposable,
and readable like any redirect field:

```php
$redirect = \Drupal\redirect\Entity\Redirect::load($rid);
$hits = (int) $redirect->access_count->value;
$last = $redirect->last_access->value; // unix timestamp or NULL if never hit
```

Query the busiest redirects directly:

```php
$ids = \Drupal::entityTypeManager()->getStorage('redirect')->getQuery()
  ->accessCheck(TRUE)
  ->sort('access_count', 'DESC')
  ->range(0, 10)
  ->execute();
```

`redirect_metrics_redirect_presave()` initialises `access_count` to `0` on new redirects when empty.

## How counting happens
`\Drupal\redirect_metrics\EventSubscriber\RedirectMetricsSubscriber` (service
`redirect_metrics.request_subscriber`, tagged `event_subscriber`, injects `@datetime.time`)
subscribes to `KernelEvents::RESPONSE`:

1. `resolveRedirect()` reads the `X_REDIRECT_ID` header off the response. The contrib `redirect`
   module sets this header on the `TrustedRedirectResponse` it returns, so metrics are recorded
   only when an actual redirect fired.
2. If a redirect id is present it loads that `Redirect`, does
   `access_count = access_count + 1`, sets `last_access = \Drupal::time()->getRequestTime()`,
   and calls `$redirect->save()`.

Cacheability: saving invalidates the redirect's cache tags *before* the page-cache entry is
created (this subscriber runs at higher priority), so anonymous responses stay cacheable and
only re-count when an authenticated user triggers the redirect or the entity is otherwise saved.
There is no counting queue or batch — it is a synchronous save on the redirecting request.

## What it does NOT add
No config entity, no settings form (`configure` is null), no permissions, no Drush, no service
you configure. To change reporting, edit the shipped `redirect_metrics` View
(see [../configure/reports.md](../configure/reports.md)).
