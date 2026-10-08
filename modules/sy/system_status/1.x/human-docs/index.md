# System Status — manual setup guide

**System Status** (`system_status`) exposes a machine-readable JSON endpoint that
reports your site's installed modules, themes and versions, so an external monitoring
service can poll it and tell you what needs updating. It is built to work with the
Lumturio monitoring platform: instead of every Drupal site checking for updates on
its own cron run, a central dashboard contacts each site, asks for its current module
inventory, and calculates the upgrade path for you across many installations at once.

Once enabled, you visit the module's settings page, copy your **site UUID**, and
enter that in your monitoring dashboard to register the site. The endpoint is
guarded by a URL token, and where the environment supports it the module encrypts the
inventory payload for the monitoring client. It has no module dependencies and ships
no submodules, and the admin settings page is gated by the **Administer site
configuration** permission.

This guide is written for a **human** setting the module up through the admin UI. If
you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — find your site UUID and register the
   site.

## Where it lives in the admin menu

Once enabled, the settings page is at
**Configuration → System → System Status** (`/admin/config/system/system_status`),
where you copy your site UUID to paste into your monitoring dashboard. The reporting
endpoint lives under `/admin/reports/system_status/{token}` and is what the
monitoring service actually fetches.
