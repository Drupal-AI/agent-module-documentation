# IVW Tracking — manual setup guide

**IVW Tracking** (`ivw_integration`) integrates **IVW / SZM audience-measurement
tracking** into your Drupal site. IVW (operated with INFOnline) is the German
industry standard for measuring website reach and usage — the audited traffic
figures German publishers report. This module adds the required IVW/SZM (SZM 2)
tracking to your pages and lets you set the measurement identifiers per section of
your site.

Rather than one fixed code for the whole site, IVW measurement uses **offering
identifiers/codes** that can vary by content, and this module drives them through
**Token-based settings** — so you can configure the right IVW code per content type
(or other context) without hard-coding it. It depends on the **Token** module and
provides its own permissions for administering the tracking.

Because this is **audience-measurement tracking, it sends usage data to a
third-party measurement provider**, which has clear privacy and consent implications.
Before you switch it on for real visitors, make sure you obtain appropriate consent,
integrate it with your cookie-consent solution, and disclose the tracking in line
with German and EU privacy law (TTDSG / GDPR). The module has no access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set your IVW/SZM identifiers, tune them
   per content type, and handle consent.

## Where it lives in the admin menu

IVW Tracking is administered behind its own permission. It provides a global settings
form for the IVW/SZM identifiers, and per-content-type settings via tokens — see
[Configuration](configuration/index.md).
