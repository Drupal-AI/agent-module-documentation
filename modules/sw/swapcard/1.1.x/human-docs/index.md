# Swapcard — manual setup guide

**Swapcard** (`swapcard`) integrates Drupal with the
[Swapcard](https://www.swapcard.com/) event platform's GraphQL API. Swapcard is a
web platform for managing events and related activities; this module gives Drupal
an authenticated API client — plus, through optional submodules, a full
content‑sync pipeline that pulls Swapcard events, sessions, speakers, and
exhibitors into Drupal nodes and keeps them up to date.

The base module is aimed mostly at **developers**. It provides a "Swapcard" plugin
type that formats GraphQL queries and sends authenticated requests over Guzzle,
plus a configuration form that stores your API key and connection options. On its
own it does not create content — it is the connection layer that other code (or
the submodules) builds on. It has no module dependencies of its own.

Two optional submodules turn it into a ready‑to‑use sync tool. **Swapcard Content**
(`swapcard_content`, which requires the Queue UI module) creates four content types
— Swapcard Events, Sessions, Speakers, and Exhibitors — with all their fields and
relationships, and synchronises them from Swapcard into Drupal via a queue worker,
on demand or on cron. **Swapcard Content Media** (`swapcard_content_media`) adds a
media image field and syncs Swapcard images (event banners, exhibitor logos,
session banners, speaker photos). Note the sync is designed for large data sets
(thousands of nodes per batch). Supports Drupal 9 and 10. The project is currently
*seeking co‑maintainers* and in maintenance‑fixes‑only mode.

On security and data flow: your Swapcard API key is stored in configuration and
sent on each request in an `Authorization` header; requests are outbound‑only and
use Guzzle's default TLS verification (it is left enabled). Because the key lives
in `swapcard.settings`, treat any exported configuration as sensitive and keep it
out of public repositories.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose which submodules you need.
2. [Configuration](configuration/index.md) — paste your API key, set the
   connection options, and (with the content submodule) run and schedule syncs.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → Web services → Swapcard**
(`/admin/config/services/swapcard/config`), gated by the *administer site
configuration* permission. With **Swapcard Content** enabled, the same form gains
sync‑related options and a **Sync** action.
