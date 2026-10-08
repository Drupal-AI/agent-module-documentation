# Nagios Monitoring — manual setup guide

**Nagios Monitoring** (`nagios`) lets an external monitoring system — Nagios,
Icinga, or really any HTTP monitor — keep an eye on your Drupal site's health. It
exposes a single plain-text **status page** (by default at `/nagios`) that
reports, in one line, whether things are OK, in a Warning state, or Critical:
has cron run recently, are there new errors in the log, is the site in
maintenance mode, are there failing status-report requirements, and more. The
same checks are also available as **Drush commands** so you can run them from
cron or a remote plugin and act on the exit code.

The status page is **disabled by default** and, once enabled, is protected — it
only returns real data to requests that identify themselves correctly, so you
don't leak your site's health to the world. A monitor authorizes itself by
sending a shared **User-Agent** string (default `Nagios`), or by passing a
matching `?unique_id=` token, or by being a logged-in administrator. You
configure the endpoint, the shared string, alert thresholds, and which checks
run, all from one settings form.

Beyond the built-in checks, other modules can contribute their own health checks
(via a simple hook), and you can exclude noisy modules from update reporting on a
second "Ignored modules" form. The module works across Drupal 8 through 11 and
ships the `check_drupal` plugin script that Nagios/Icinga uses to parse the
output.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable and secure the status page,
   set the shared User-Agent, tune thresholds and checks, and use the Drush
   commands.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → Nagios
monitoring** (`/admin/config/system/nagios`), with a separate **Ignored modules**
form at `/admin/config/system/nagios/ignored_modules`. The monitored status page
itself is served at the path you configure (default `/nagios`).
