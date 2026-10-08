# Extend — data sources & events

Smart IP does **not** use a plugin manager for geolocation providers. A "data source" is an
**event subscriber** that implements `SmartIpDataSourceInterface`. Enable the module, then select
its `sourceId()` as `smart_ip.settings:data_source`.

## Writing a data source

Extend `Drupal\smart_ip\SmartIpEventSubscriberBase` (it implements
`SmartIpDataSourceInterface` + `EventSubscriberInterface` and already wires the events):

```php
class SmartIpEventSubscriber extends SmartIpEventSubscriberBase {
  public static function sourceId(): string { return 'my_source'; }        // the data_source value
  public static function configName(): string { return 'my_module.settings'; }
  public function processQuery(GetLocationEvent $event) { /* fill $event->getLocation() */ }
  public function formSettings(AdminSettingsEvent $event) { /* add admin sub-form */ }
  public function validateFormSettings(AdminSettingsEvent $event) {}
  public function submitFormSettings(AdminSettingsEvent $event) {}
  public function manualUpdate(DatabaseFileEvent $event) {}   // binary-db sources
  public function cronRun(DatabaseFileEvent $event) {}        // binary-db sources
}
```

Register it as a service tagged `event_subscriber`. `SmartIpEventSubscriberBase::getSubscribedEvents()`
maps the interface methods to the Smart IP events automatically:

| Method | Event constant | Event string |
|---|---|---|
| `processQuery` | `SmartIpEvents::QUERY_IP` | `smart_ip.query_ip_location` |
| `includeEditableConfigNames` | `SmartIpEvents::GET_CONFIG_NAME` | `smart_ip.get_editable_config_names` |
| `formSettings` | `SmartIpEvents::DISPLAY_SETTINGS` | `smart_ip.display_admin_settings` |
| `validateFormSettings` | `SmartIpEvents::VALIDATE_SETTINGS` | `smart_ip.validate_admin_settings` |
| `submitFormSettings` | `SmartIpEvents::SUBMIT_SETTINGS` | `smart_ip.submit_admin_settings` |
| `manualUpdate` | `SmartIpEvents::MANUAL_UPDATE` | `smart_ip.manual_database_update` |
| `cronRun` | `SmartIpEvents::CRON_RUN` | `smart_ip.cron_run` |

In `processQuery()`, populate the location via the event's `SmartIpLocation`
(`$event->getLocation()->set('countryCode', ...)`), setting the standard keys (country,
countryCode, region, regionCode, city, zip, latitude, longitude, timeZone). Smart IP's
`updateFields()` derives the rest (names, EU flag, time zone).

## All Smart IP events (`Drupal\smart_ip\SmartIpEvents`)

- `QUERY_IP` = `smart_ip.query_ip_location` — the active source fills the location.
- `DATA_ACQUIRED` = `smart_ip.data_acquired` — **any module** can alter the finished result here.
- `GET_CONFIG_NAME` = `smart_ip.get_editable_config_names` — add a source's config name to the
  admin form's editable set.
- `DISPLAY_SETTINGS` / `VALIDATE_SETTINGS` / `SUBMIT_SETTINGS` — admin-form build/validate/submit.
- `MANUAL_UPDATE` = `smart_ip.manual_database_update` — manual DB refresh (binary sources).
- `CRON_RUN` = `smart_ip.cron_run` — periodic DB refresh (binary sources).

## Just altering results

To adjust an existing lookup without writing a full source, subscribe to
`SmartIpEvents::DATA_ACQUIRED` and mutate `$event->getLocation()`.

## The bundled sources

This project ships six sources; each is a `SmartIpEventSubscriberBase` subclass with its own
`sourceId()`/`configName()` — see the `modules/` subtree:
`maxmind_geoip2_bin_db`, `maxmind_geoip2_web_service`, `ip2location_bin_db`,
`ipinfodb_web_service`, `abstract_web_service`, and `device_geolocation` (W3C client-side).
