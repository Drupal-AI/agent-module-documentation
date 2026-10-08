# Monitoring — manual setup guide

**Monitoring** (`monitoring`) is a pluggable health-check framework for Drupal.
Instead of one fixed report, it is built around **sensors**: each sensor measures a
single thing — how long since cron last ran, how many errors are in the log, whether
core's requirements are satisfied, disk and OPcache usage, the number of content
entities of a type, a specific config or state value, and dozens more — evaluates
that measurement against **thresholds**, and reports a status of **OK**, **WARNING**,
**CRITICAL**, or **UNKNOWN**. Those results are visible in a dashboard, on the command
line, and over REST, ready to feed external monitoring systems like Nagios/Icinga,
Prometheus, or Munin.

The module ships around forty sensor plugins and automatically creates matching
sensors as you install related modules — so a fresh install already watches cron,
watchdog/dblog, core requirements, and content, and it grows as your site does. Each
live sensor is a configuration entity that stores which plugin it uses, its category,
its caching time, its plugin settings, and its warning/critical thresholds, so the
whole monitoring setup exports and deploys with your configuration.

You review results at **Reports → Monitoring**, manage the sensors themselves at
**Configuration → System → Monitoring → Sensors**, and control global behavior (call
logging, watchdog logging, and whether sensors run on cron) at **Configuration →
System → Monitoring → Settings**. A set of Drush commands (`monitoring:run`,
`:list-sensors`, `:enable`, `:disable`, `:rebuild`, `:sensor-config`) drives
everything from the CLI, with the exit code of `monitoring:run` reflecting the worst
sensor status — perfect for gating CI or alerting. Four permissions separate viewing
reports from administering sensors, and developers can add their own sensor by writing
a `SensorPlugin`.

Monitoring depends on core's **Views** module and comes with several optional
submodules: escalation email (**monitoring_mail**), Munin-style multigraphs
(**monitoring_multigraph**), a Prometheus exporter (**monitoring_prometheus**), a demo
(**monitoring_demo**), and test fixtures (**monitoring_test**).

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the services, the procedural
API, and how to write a sensor — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and choose any submodules you need.
2. [Configuration](configuration/index.md) — the sensor overview and how to tune a
   sensor's thresholds, the global settings form, the results dashboard, the Drush
   commands, and the permissions.

## Where it lives in the admin menu

Monitoring adds three main places to visit:

- **Reports → Monitoring** (`/admin/reports/monitoring`) — the results dashboard,
  showing each sensor's current status.
- **Configuration → System → Monitoring → Sensors**
  (`/admin/config/system/monitoring/sensors`) — add, edit, delete, and rebuild
  sensors.
- **Configuration → System → Monitoring → Settings**
  (`/admin/config/system/monitoring/settings`) — global behavior.

See [Configuration](configuration/index.md) for a walkthrough of each.
