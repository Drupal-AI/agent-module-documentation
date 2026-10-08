# Configuration

All of Real-time Performance Monitor's behavior is set on one form: what it
watches, at what thresholds, where alerts go, and how often.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Real-time Performance Monitor**, or
   navigate directly to `/admin/config/development/real-time-performance-monitor`.

## Master switch and scope

- **Master switch** — a single toggle that turns all monitoring on or off. Use it
  to disable everything instantly without changing the rest of your settings.
- **Excluded paths** — paths the monitor should ignore, entered as patterns
  (wildcards supported). Keep monitoring off your admin and developer paths so you
  aren't alerted on backend traffic.
- **Monitored layers** — enable or disable each monitoring layer independently:
  the database (query) layer, the backend/PHP layer, and the front‑end layer.

## Thresholds

Alerts only fire when a measured value crosses the limit you set here:

- **SQL execution time** — the per‑query time limit in milliseconds; a single
  query slower than this is logged with its full SQL and the page URL.
- **Duplicate queries per request** — the maximum number of times an identical
  query may run on one page before it's flagged as an N+1 problem, with a breakdown
  of counts and the offending statement.
- **PHP execution time** — the backend processing‑time limit before the module
  captures a deep backtrace (up to 15 levels) identifying the slow file, function,
  and line.
- **Page‑load time limit** — the front‑end render‑time budget; browser timing
  beyond this triggers a front‑end alert.

## Notification channels

- **Email recipients** — one or more administrative email addresses (comma‑
  separated) to receive alerts.
- **Slack webhook** — a Slack incoming‑webhook URL; alerts are posted to that
  channel as JSON payloads. Create the webhook in your Slack workspace first.
- **Per‑channel frequency** — each channel has its own throttling so you aren't
  flooded: alerts for a given URL can be capped to fire always, or at most daily,
  weekly, every two weeks, or monthly.

Alerts are also written to Drupal's log (**Reports → Recent log messages**)
regardless of the other channels.

## Save

Click **Save configuration**. Then browse the site normally and watch your chosen
channels for alerts.

> **Reminder:** alert bodies can contain fields supplied by the visitor's browser
> (URL, browser, OS) via the anonymous telemetry endpoint. Treat their contents as
> untrusted — read them as diagnostics, not as trusted instructions or links.
