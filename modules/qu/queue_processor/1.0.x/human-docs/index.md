# Queue Processor — manual setup guide

**Queue Processor** (`queue_processor`) drains Drupal's queues automatically at the
end of each page request, so background tasks run without you having to set up cron.
It hooks into Symfony's `kernel.terminate` event — the same non‑blocking pattern
Drupal core uses for automated cron — which means processing happens *after* the
response has already been sent to the visitor, with no impact on page‑load times.
Every bit of normal site traffic becomes an opportunity to work through your queues.

What makes it more than a cron replacement is the control it gives you. You choose
which queues it processes, set a **priority** for each (0–100, lower runs first) so
that critical work like order‑confirmation emails beats low‑priority work like
search indexing, and cap how long processing may run — both a global per‑request
budget and an optional per‑queue limit. You can also cap how many items each queue
handles per request and skip processing on admin pages to keep the back office
snappy. If the **Queue UI** module is installed, Queue Processor discovers your
queues automatically and offers checkboxes instead of hand‑typed names.

It is a good fit for shared hosting where cron is unreliable, for e‑commerce sites
that need dependable email and inventory queues, and for development environments
where you want to exercise queue workers without configuring cron. Because workers
run in the context of ordinary front‑end requests, note that they execute with
whatever privileges that request has (including anonymous requests).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no separate configuration page in this guide — the settings form is
covered in "Configure it" below.

## Where it lives in the admin menu

After enabling, the settings form is at **Configuration → System → Queue Processor**
(`/admin/config/system/queue-processor`), gated by the **Administer site
configuration** permission. Automatic processing is on by default once the module is
enabled.

## Configure it

Open **Configuration → System → Queue Processor**
(`/admin/config/system/queue-processor`) as a user with **Administer site
configuration**. The form has global settings and a per‑queue section:

**Global settings**

- **Enable automatic queue processing** — the master on/off switch (on by default).
- **Items per queue per request** — the maximum number of items each queue handles
  in a single request (default **10**; raise for faster draining, lower for a
  lighter load).
- **Maximum execution time** — the total per‑request budget shared across all
  queues, 1–60 seconds (default **5**). A rough guide: 2–3 seconds for high‑traffic
  sites, 10–15 for low‑traffic ones.
- **Run on admin routes** — leave unchecked (the default) to skip processing on
  `/admin/*` pages and keep the back office responsive.
- **Logging** — how much detail to record: errors and warnings, INFO summaries, or
  everything.

**Per‑queue settings**

Each discovered queue worker appears as its own section (a checkbox list when Queue
UI is installed). For every queue you enable, you can set:

- **Priority** — 0–100, where **lower is processed first** (default 50).
- **Time limit** — seconds allotted to that queue; `0` means "use whatever global
  time remains". Only enabled queues are saved.

Click **Save configuration** when done. As an example, an e‑commerce site might set
`order_confirmation_email` to priority 5 with a 2‑second limit, `shipping_notification`
to priority 10, and `search_api_indexing` to priority 70 with time limit 0 so it
uses leftover time.

## Monitoring

Check **Reports → Recent log messages** (`/admin/reports/dblog`) and filter by the
type **queue_processor** to see processing statistics (items processed, duration),
queue suspensions, errors, and time‑limit notices.

## For developers

The module fires `hook_queue_processor_queues_alter(array &$queues)`, letting you
adjust queue enablement, priority, or time limits at runtime — for example, boosting
the email queue's priority during business hours.
