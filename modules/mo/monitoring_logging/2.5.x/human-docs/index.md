# Monitoring Logging — manual setup guide

**Monitoring Logging** (`monitoring_logging`) extends the
[Monitoring](https://www.drupal.org/project/monitoring) module by writing an
overview of sensor results to a log. Monitoring runs "sensors" that check site
health — failed logins, queue sizes, error counts and so on — and this module
records their outcomes, giving you a time-stamped history of sensor status that you
can review over time, feed into trend analysis, or forward to an external log
platform or SIEM.

Rather than a single fixed output, it provides a small **framework for logging
plugins**: a plugin decides *where* results go and a formatter plugin decides *how*
they are formatted. The module ships an example implementation that logs results to
a file, and a submodule,
**`monitoring_logging_check_drupal`**, that formats the log so it can be read by
the Drupal Nagios plugin.

This is an administration/observability tool with no content or access-control
role. It depends on the Monitoring module and works on Drupal 9.4 through 11.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus the optional Nagios-format submodule).

There is **no dedicated settings form** for this module — its behaviour comes from
which logging plugin is active. Setup is really just enabling the module (and the
submodule if you want Nagios-readable output), described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). With Monitoring
   already running its sensors, their results are recorded to the log — the shipped
   example implementation logs to a file via a formatter plugin.
2. If you want output the **Drupal Nagios plugin** can read, also enable the
   `monitoring_logging_check_drupal` submodule, which provides a formatter plugin
   for that format.
3. Review the logged sensor history for audit, trend analysis, or forwarding to a
   SIEM / log-aggregation platform.

> **A note on volume:** if you run many sensors frequently, they will produce a
> correspondingly large volume of log entries. Keep an eye on log size and rotate
> or forward logs as appropriate.
