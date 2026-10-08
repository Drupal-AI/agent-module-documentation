# Configure

Settings form `Drupal\ohdear_integration\Form\SettingsForm` at route
`ohdear_integration.settings` → `/admin/config/system/ohdear-settings`
(permission `administer site configuration`; menu link under System config).
Config object: `ohdear_integration.settings`.

## Config keys
| Key | Form field | Purpose |
|---|---|---|
| `ohdear_healthcheck_secret` | textfield | Shared secret Oh Dear sends to reach the health-check endpoint |
| `ohdear_cron_uri` | textfield | Oh Dear scheduled-tasks ping URL (pinged on cron) |
| `ohdear_api_key` | password | Oh Dear API token (SDK calls, drush, report pages) |
| `ohdear_monitor_id` | number (int) | Oh Dear monitor id for this site |
| `healthcheck_cache_max_age` | *(none — code only)* | Optional int seconds; enables endpoint caching (see api/healthcheck-endpoint.md) |

The API-key field is `#type => password`; `submitForm()` only re-saves it when a
non-empty value is submitted, so leaving it blank preserves the stored key. The other
three fields are saved unconditionally.

## Environment overrides
These env vars take precedence over the stored config wherever the value is read:
`OHDEAR_API_KEY`, `OHDEAR_HEALTHCHECK_SECRET`, `OHDEAR_MONITOR_ID`, `OHDEAR_CRON_URI`.
The form prints a warning listing whichever of them are currently set.

## Set via drush / PHP
```bash
drush cset ohdear_integration.settings ohdear_healthcheck_secret '<secret>' -y
drush cset ohdear_integration.settings ohdear_monitor_id 30556 -y
drush cset ohdear_integration.settings ohdear_cron_uri 'https://ping.ohdear.app/<uuid>' -y
```
```php
\Drupal::configFactory()->getEditable('ohdear_integration.settings')
  ->set('ohdear_api_key', '<token>')
  ->set('healthcheck_cache_max_age', 60)
  ->save();
```

## Schema
`config/schema/ohdear_integration.schema.yml` types `ohdear_integration.settings` as a
`config_object` with strings `ohdear_healthcheck_secret` / `ohdear_cron_uri` /
`ohdear_api_key` and integer `ohdear_monitor_id`. `healthcheck_cache_max_age` is read by
`OhDearSdkService::getHealthcheckCacheMaxAge()` but is not declared in the schema — add
it manually (drush/config edit) when enabling endpoint caching.

## Update hook
`ohdear_integration_10000()` migrates the legacy config key `ohdear_site_id` to
`ohdear_monitor_id` (the SDK 3.x→4.x `site_id`→`monitor_id` rename).
