# LocalGov Alert Banner Collapsible — manual setup guide

**LocalGov Alert Banner Collapsible** (`localgov_alert_banner_collapsible`) is an
add‑on for the [LocalGov Alert Banner](https://www.drupal.org/project/localgov_alert_banner)
module, part of the **LocalGov Drupal** distribution (the shared Drupal platform
built for and by UK councils). It adds a **collapsible** alert banner block, so a
site‑wide alert can be collapsed and expanded by the visitor rather than
permanently hidden — which means a resident who collapses a notice can still get
it back again.

This is useful for persistent‑but‑not‑intrusive notices: an alert stays available
without dominating every page, and visitors keep control over whether it is
expanded.

> **Note:** this is an **experimental** module. Alert banners whose
> `remove_hide_link` field is set are shown in a separate persistent‑alerts
> section above the collapsible block. That persistent section currently does not
> set the `hide-alert-banner-token` cookie and has no way to tell whether a
> visitor has already seen a given alert.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (LocalGov Alert Banner is required).

This module has **no settings form of its own** — it provides a block and works
alongside the alert banner entities you already manage through LocalGov Alert
Banner (see "How to use it").

## Where it lives in the admin menu

The module adds a collapsible alert banner **block**. You place and manage it
through Drupal's block system (**Structure → Block layout**) or your theme's block
configuration, and you continue to create and edit the alerts themselves through
LocalGov Alert Banner as usual.

## How to use it

1. Make sure LocalGov Alert Banner is set up and you have one or more alert
   banners created.
2. Place the collapsible alert banner block provided by this module in the region
   where your alerts should appear.
3. Visitors can now collapse and expand the alert instead of only dismissing it —
   a collapsed alert can be reopened. Keep the experimental caveat above in mind
   for banners that use the "remove hide link" option.
