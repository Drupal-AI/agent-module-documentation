# Javali Error Pages — manual setup guide

**Javali Error Pages** (`javali_error_pages`) adds custom **403 (access denied)**,
**404 (page not found)**, and **maintenance‑mode** pages to your site. Instead of
the plain, unbranded defaults Drupal shows when a visitor hits a forbidden URL, a
missing page, or a site that's temporarily offline, you get friendlier, on‑brand
pages that fit the rest of your site.

It's a presentation feature: it changes **how** an error response looks, not
**who** receives one. Enabling it does not alter access control — a 403 is still a
403 for the same people; it just looks better. That makes it a safe, low‑risk
addition for improving the experience visitors have when something goes wrong.

The module is small, has no dependencies beyond Drupal core, and supports a wide
range of core versions (8 through 11).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no dedicated settings form of its own. Once enabled it provides
the custom error pages; you manage which pages Drupal serves for the 403 and 404
responses the same way you always would — from **Configuration → System → Basic
site settings** (`/admin/config/system/site-information`), under the **Error
pages** section — and you control maintenance mode from **Configuration →
Development → Maintenance mode** (`/admin/config/development/maintenance`).

## Where it lives in the admin menu

Javali Error Pages adds no admin page of its own. The error and maintenance
behaviour it enhances is managed through core's existing settings noted above.
