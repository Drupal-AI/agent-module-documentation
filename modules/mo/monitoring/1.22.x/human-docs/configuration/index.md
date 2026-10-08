# Configuration

Monitoring is configured in three areas: the **sensors** (what gets measured and the
thresholds that decide the status), the **global settings** (how the framework
behaves), and the **results dashboard** where you read the outcome. This page walks
through each, plus the Drush commands and the permissions.

## The results dashboard

Start at **Reports → Monitoring** (`/admin/reports/monitoring`). This is the overview
of every enabled sensor with its current status — OK, WARNING, CRITICAL, or UNKNOWN —
grouped by category (Cron, Content, Watchdog, Security, and so on). Click a sensor to
see its detail page, including its value and any verbose diagnostic output. Viewing
this page requires the **Monitoring reports** permission.

To get a fresh, uncached result immediately, use the **Force run** action (all
sensors, or one) — this needs the **Monitoring force run** permission.

## Managing sensors

Go to **Configuration → System → Monitoring → Sensors**
(`/admin/config/system/monitoring/sensors`) to see the full list of sensors and add,
edit, delete, enable, or disable them. Two buttons are worth knowing:

- **Add sensor** — create a new sensor instance from one of the shipped sensor
  plugins (for example the "config value" or "state value" plugins that compare a
  value to an expected one).
- **Rebuild sensor list** — re-scan for sensors that can be auto-created (run this
  after installing or removing modules so new default sensors appear).

### Editing a sensor's thresholds

Each sensor is a small configuration entity. On a sensor's edit form you can set its
label, category, caching time (how long a result is reused before the sensor runs
again), any plugin-specific **settings**, and — most importantly — its
**thresholds**. Thresholds are how a raw measurement becomes a status. A threshold has
a *type* and warning/critical bounds:

- **exceeds** — WARNING/CRITICAL when the value rises **above** the bound. For
  example, the cron-age sensor uses `warning: 86400` (1 day) and `critical: 259200`
  (3 days), so it warns when cron has not run for a day and goes critical after three.
- **falls** — WARNING/CRITICAL when the value drops **below** the bound.
- **inner** / **outer** — WARNING/CRITICAL when the value is inside (or outside) a
  low/high range.

Tune these to match what "healthy" means for your site. When you save, the change is
stored in the sensor's config entity (`monitoring.sensor_config.<id>`), so it exports
with the rest of your configuration.

### Enable, disable, or tune from Drush/config

You do not have to use the form. Enable or disable a sensor by machine name:

```bash
drush monitoring:enable core_cron_last_run_age
drush monitoring:disable dblog_404
```

Or load the `monitoring_sensor_config` entity in code/config, adjust its `status`,
`thresholds`, or `settings`, and save.

## Global settings

Go to **Configuration → System → Monitoring → Settings**
(`/admin/config/system/monitoring/settings`) for the framework-wide behavior. The
settings are:

- **Sensor call logging** (`sensor_call_logging`, default *on request*) — when to log
  sensor calls: never, only on request, or every call.
- **Watchdog logging** (`watchdog_logging`, default off) — also send sensor results to
  Drupal's log.
- **Run sensors on cron** (`cron_run_sensors`, default off) — turn this on so sensors
  run automatically during cron rather than only when viewed or invoked.
- **Disable sensor auto-create** (`disable_sensor_autocreate`, default off) — stop
  Monitoring from ever auto-creating new sensors when modules change.

These live in the `monitoring.settings` config object and can also be set with
`drush cset monitoring.settings <key> <value>`.

## Drush commands

Monitoring is fully driveable from the command line — this is how most people wire it
into external alerting:

| Command | Purpose |
|---------|---------|
| `drush monitoring:run [sensor]` | Run all sensors (or one). The exit code reflects the worst status, so it can gate CI/alerting. |
| `drush monitoring:list-sensors` | List all sensors (label, name, category, enabled). |
| `drush monitoring:sensor-config [sensor]` | Show the configuration of all sensors or one. |
| `drush monitoring:enable <sensor>` | Enable a sensor. |
| `drush monitoring:disable <sensor>` | Disable a sensor. |
| `drush monitoring:rebuild` | Rebuild the sensor list (pick up new auto-createable sensors). |

Useful options on `monitoring:run` include `--force` (ignore the cached result and
run fresh), `--verbose` (include each sensor's diagnostic output), and `--format=json`
(machine-readable output for Nagios/Sensu/etc.). There are also dedicated Sensu
integration flags.

```bash
drush monitoring:run                                # all sensors
drush monitoring:run core_cron_last_run_age --force # one sensor, uncached
drush monitoring:run --format=json                  # machine-readable
```

## Permissions

Grant these at **People → Permissions**:

- **Administer monitoring** (`administer monitoring`) — add/edit/delete sensors, the
  settings form, the sensor overview, and rebuild. Reserve for administrators.
- **Monitoring reports** (`monitoring reports`) — view the results dashboard and
  per-sensor detail. Grant to operators who need to watch site health.
- **Monitoring verbose** (`monitoring verbose`) — see verbose sensor configuration and
  output.
- **Monitoring force run** (`monitoring force run`) — force an uncached sensor run from
  the UI.

The **monitoring_prometheus** submodule adds its own permission, *access monitoring
prometheus metrics*, for the `/metrics` endpoint.

## Adding your own sensor (developers)

Anything you can measure in PHP can become a sensor: implement a `SensorPlugin`
(plugin type `monitoring.sensor`) and register a `monitoring_sensor_config` entity for
it. See the [`agent/`](../agent/start.md) docs for a minimal plugin example and the
full list of shipped sensor plugin ids.
