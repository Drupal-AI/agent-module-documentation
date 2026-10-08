<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DropWatch is a client module that reports a Drupal site's version, module/theme and update-status data to the external DropWatch update-monitoring service.

---

DropWatch is the Drupal-side client for the DropWatch SaaS (https://dropwatch.sh), an app that aggregates the update/security status of many Drupal sites into one dashboard. On each cron run (and on demand via a manual-sync form) the module builds a payload describing the site — Drupal core version and available updates, PHP/web-server/database details, the list of installed contrib projects with their versions and recommended releases, and optionally PHP error logs from watchdog — and POSTs it as JSON to the DropWatch API. Which sections are sent is controlled by per-category checkboxes on the settings form; the site's identifying URL and the outbound API token are supplied by the operator. It requires a DropWatch account and depends on Drupal core's Update Manager (`update`) module. This is a pre-release (1.0.0-beta7).

---

- Report a site's Drupal core version and recommended core update to a central dashboard.
- Track which of many sites need security updates from one place.
- Send the installed contrib module list with versions and lifecycle status.
- Send recommended-version and release info for modules that are out of date.
- Report PHP version, memory limit, APCu availability, and OPcache status.
- Report the web-server version.
- Report the database system and version, plus pending DB updates.
- Optionally forward PHP error/warning log entries (from watchdog) for remote review.
- Sync automatically every time Drupal cron runs (via `hook_cron`).
- Trigger an immediate, on-demand sync from the "Manual sync" admin form.
- Choose exactly which data categories to transmit via checkboxes.
- Identify the site to DropWatch with a configurable Site URL.
- Authenticate the outbound API call with a per-site Bearer token.
- Increase sync frequency by pairing cron with Ultimate Cron.
- Restrict who can configure the integration via the `administer dropwatch` permission.
- Centralize monitoring for an agency managing many Drupal sites.
- Detect newly released security patches across a fleet without checking each site by hand.
- Keep an inventory of contrib versions running in production.
- Feed a compliance/patch-management workflow with current site telemetry.
- Verify configuration by running a manual sync and checking the logs for errors.
