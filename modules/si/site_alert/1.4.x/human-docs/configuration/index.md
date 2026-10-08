# Configuration

Setting up Site Alert is two steps: create one or more alerts, then place the
block that displays them.

## Create an alert

1. Log in as a user with the **Administer site alert** permission (an
   administrator by default).
2. Go to **Configuration → System → Site Alerts**
   (`/admin/config/system/site-alerts`) and click **Add site alert**.
3. Fill in the fields:
   - **Label** *(required)* — an internal name to identify the alert. It is not
     shown to visitors.
   - **Active** — on by default. Uncheck it to hide the alert while keeping it
     for later reuse.
   - **Severity** *(required)* — **Low**, **Medium**, or **High**. This drives a
     `severity-…` CSS class so your theme can style it (for example, high in
     red).
   - **Message** *(required)* — the banner text shown to visitors.
   - **Scheduling** — an optional start and end date/time. Leave either or both
     empty. An alert shows when it is active **and** the current time is at or
     after the start (or there is no start) **and** before the end (or there is
     no end).
4. Save. Repeat to create as many alerts as you need — several can be active at
   once.

## Place the Site Alert block

The banner only appears once its block is placed:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region where you want the banner, click **Place block** and choose
   **Site Alert**.
3. Configure the block (see below) and save.

### Block setting: Timeout

The block has one setting, **Timeout** — the number of seconds between AJAX
refreshes (default **300**). Because the block polls the server on this timer,
scheduled alerts appear and expire on time even when pages are served from
cache. Set it lower for more responsive alerts, higher to reduce requests, or to
**0** to disable polling entirely (alerts then only update on a normal page
load).

## Managing alerts from the command line (Drush)

Site Alert ships Drush commands, handy for deploy scripts and CI/CD:

```bash
# Create an immediate, medium-severity alert
drush site-alert:create "maint" "We are performing maintenance."

# High severity, created disabled until you enable it
drush site-alert:create "launch" "New feature is live!" --severity=high --no-active

# A scheduled maintenance window
drush site-alert:create "window" "Downtime 3-5pm" \
  --start=2026-08-10T15:00:00 --end=2026-08-10T17:00:00

drush site-alert:enable "launch"     # activate alert(s) with that label
drush site-alert:disable "launch"    # deactivate one label...
drush site-alert:disable             # ...or ALL active alerts if no label given
drush site-alert:delete "maint"      # delete (prompts to confirm)
```

`--severity` accepts `low`, `medium` (default), or `high`. `--start` / `--end`
accept ISO 8601 timestamps or human strings like `"tomorrow 13:45"` or
`"+6 hours"`, and are stored in UTC.

## A note on who can create alerts

The module provides four permissions: **Administer site alert** (full
management), **Add site alerts**, **Update site alerts**, and **Delete site
alerts**. Viewing alerts is not gated — every visitor sees active alerts.

Be aware that the alert **message** is rendered as admin‑level markup: scripts
and event handlers are stripped, but a broad set of HTML tags is allowed, and
there is no per‑field text‑format restriction. In practice this means anyone who
can add or update alerts can put rich HTML site‑wide in front of every visitor.
Treat the **Add / Update site alerts** permissions as trusted‑author roles and
do not grant them to low‑trust users.
