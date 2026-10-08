# Drupical — manual setup guide

**Drupical** (`drupical`) shows upcoming Drupal community events — DrupalCons, camps,
meetups, trainings and more — pulled live from the official Drupal.org events API, in
an **Events Feed** block you can place anywhere on your site or on the admin dashboard.

The module provides a single block, **Events Feed**. Behind it, a fetcher service
reads the Drupal.org events feed, sorts it so featured DrupalCon events come first and
then by soonest start date, and caches the result so the external API is only queried
periodically rather than on every page load. Cron refreshes that cache automatically.
The block shows a handful of events with an AJAX **Load More** button for browsing
further.

It is a nice, low‑maintenance "what's happening in Drupal" widget for a community
site's homepage, an intranet dashboard, or the administrative dashboard used by
Drupal CMS. It requires no modules outside core and pairs well with the Dashboard
module.

Drupical has **no admin settings form**. Its three tunables (how long events are
cached, how often cron re‑fetches, and how many events to display) live in a
configuration object you edit from the command line, and access to the feed is
controlled by a single permission. This guide is written for a **human**; if you want
terse, token‑cheap references for an AI coding agent — the services and the `Event`
value object — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — placing the Events Feed block, granting
   the permission, and tuning the three settings.

## Where it lives in the admin menu

Drupical adds no configuration page of its own. You place its **Events Feed** block
through the normal **Structure → Block layout** (`/admin/structure/block`), or add it
to the administrative dashboard if you use the Dashboard module. Visibility of the
block is controlled by the **Access events** permission on **People → Permissions**.
