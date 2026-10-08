# Visitors — manual setup guide

**Visitors** (`visitors`) is a native, self‑hosted web‑analytics module for Drupal.
Instead of sending your traffic data to a third‑party service like Google Analytics,
it logs each visit to its own database table inside your site and renders the reports —
recent hits, top pages, hosts, referrers, devices, browsers, operating systems and more —
as Views listings and Chart.js charts right in the Drupal admin. That makes it a
privacy‑friendly, "your data stays on your server" alternative for basic site
statistics.

A small JavaScript tracker is attached to your pages and posts each visit to an internal
`/visitors/_track` endpoint, which records it to the `visitors` log table. A visibility
service decides which pages, roles, and users are tracked, so you can exclude admin
pages, skip the superuser, or track only certain roles. Device, browser and OS details
come from the bundled matomo/device‑detector library, and optional country/region/city
reports come from the separate **Visitors GeoIP** submodule. There's also an optional
per‑content hit counter that shows a "N views" figure on nodes.

Everything is driven by one settings form at **Configuration → System → Visitors**, plus
a set of "rebuild" tools that can recompute route, IP‑address, and device data for
historic log rows (handy after a URL change or when you enable a new kind of derivation).
A cron job prunes old log entries based on the retention timers you set. Three
permissions control who can see the reports, who can opt out of tracking, and who sees
the hit counter.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its libraries with
   Composer, enable it, and add the optional GeoIP submodule.
2. [Configuration](configuration/index.md) — the settings form field by field, the
   rebuild tools, permissions, and the reports.

## Where it lives in the admin menu

- **Reports** live at **`/visitors`** (top‑level, gated by the *access visitors*
  permission): recent hits, top pages, hosts, referrers, devices, and so on.
- **Settings** live at **Configuration → System → Visitors**
  (`/admin/config/system/visitors`), where you also find the rebuild tools under
  `/admin/config/system/visitors/rebuild-*`.
