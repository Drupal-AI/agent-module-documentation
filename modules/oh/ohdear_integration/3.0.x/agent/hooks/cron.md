# hook_cron — scheduled-tasks ping

`ohdear_integration_cron()` (in `ohdear_integration.module`) drives Oh Dear's
Scheduled-tasks (cron) monitoring. On every Drupal cron run, if a ping URI is configured
— env `OHDEAR_CRON_URI` else config `ohdear_cron_uri` — it issues:

```php
\Drupal::httpClient()->request('GET', $cron_uri);
```

Any `\Throwable` is caught and logged as a warning (`ohdear_integration` channel); a
failed ping never blocks the cron run. Obtain the ping URL from Oh Dear's Scheduled-tasks
tab for the monitor and set it in the settings form. Only the default Drupal cron is
supported.
