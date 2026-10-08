# Real-time Performance Monitor — manual setup guide

**Real-time Performance Monitor** (`real_time_performance_monitor`) is a
lightweight diagnostic watchdog for your Drupal site. It watches real user traffic
for the performance problems that usually only surface in production — slow SQL
queries, duplicate (N+1) queries, slow PHP execution, and sluggish front‑end page
loads — and fires an instant alert to your logs, email, and/or Slack when a
threshold you set is crossed.

Unlike full APM platforms that need daemons and agents installed on the server,
this module works from inside Drupal's own architecture, so you get actionable
alerts without heavy production overhead. When a slow query is caught it logs the
full SQL statement and the exact page URL; when the same query runs too many times
on one page it reports the count and the offending statement; when PHP is slow it
captures a backtrace up to 15 levels deep pointing at the file, function, and line
responsible; and a small front‑end script reports browser timing (load time,
time‑to‑first‑byte, first contentful paint, and CSS/JS payload sizes).

Everything is controlled from one settings form: a master on/off switch, which
layers to monitor, the thresholds, paths to exclude, and where alerts go — email
recipients and a Slack incoming‑webhook URL — each with its own frequency cap so
you aren't flooded.

> **Security note — the telemetry endpoint is anonymous by design.** So the
> browser can post its timing data without a session, the front‑end telemetry
> route is open to anonymous requests, and fields from that request (such as the
> URL, browser, and OS) are placed into the alert body that is logged and
> emailed/Slacked to administrators. Treat those alerts as **untrusted,
> browser‑supplied content** — don't act on their contents blindly. Note also that
> this project is **not covered by Drupal's security advisory policy**, so weigh
> that before enabling it on a high‑value production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the thresholds, monitored layers,
   path exclusions, and alert channels.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Real-time Performance
Monitor** (`/admin/config/development/real-time-performance-monitor`), gated by the
**Administer site configuration** permission.
