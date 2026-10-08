# Simple Analytics — manual setup guide

**Simple Analytics** (`simple_analytics`) does two related jobs, and you can use
either or both. First, it can **inject a third-party analytics snippet** into your
pages — a Google Analytics ID, a Matomo/Piwik URL and site id, or any custom
script/noscript markup you paste in. Second, it can run its own **built-in visitor
tracker**, storing visits and page views in your database and showing them in admin
reports (today, a live counter, per-visitor detail, and history charts) without
relying on an external service.

Out of the box the internal tracker is enabled, and sensibly it does **not** track
admin pages (`/admin/`) or authenticated users, so you are counting real front-end
visitors by default. You can narrow it further — exclude specific URLs, show or hide
the injected code on admin pages, or serve it only to anonymous users. A daily
archiving step aggregates yesterday's data and purges rows older than a duration you
set, keeping the tables from growing without bound. History charts can use the
optional Chartist JavaScript library if you install it.

The module provides its own permissions: viewing the statistics history is gated by
*view* permissions (which you can extend to anonymous users if you want a public
counter), and the settings page is behind a restricted *admin* permission. It ships
one optional submodule, **Simple Analytics Event** (`simple_analytics_event`), an
example that demonstrates subscribing to the tracker's events. This branch supports
Drupal 8, 9, and 10, and note the project is **not covered by Drupal's security
advisory policy**.

One design point worth understanding: the internal tracker records visits by
accepting a request to a deliberately open endpoint (`/simple_analytics/api/track`).
That is how client-side tracking works, but it means the endpoint accepts posted
data from anyone with no throttling, so the stored figures are best treated as
indicative traffic analytics rather than a tamper-proof audit trail. The reports
render stored values through Drupal's table theming, which escapes them, so the data
is displayed safely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally add the Chartist library and the event submodule.
2. [Configuration](configuration/index.md) — choose the tracking mode(s), enter your
   analytics IDs, set exclusions and archiving, and manage permissions.

## Where it lives in the admin menu

The settings are at **Configuration → System → Simple Analytics settings**
(`/admin/config/system/analyse`), reachable only by an administrator. The built-in
reports live under **Reports → Simple Analytics**
(`/admin/reports/simple_analytics`), where the today/live/visitor/history views
appear according to your permissions.
