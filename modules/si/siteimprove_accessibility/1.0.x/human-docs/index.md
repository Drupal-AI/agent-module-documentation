# Siteimprove Accessibility — manual setup guide

**Siteimprove Accessibility** (`siteimprove_accessibility`) brings Siteimprove's
open‑source **Alfa** accessibility engine into Drupal. It scans rendered pages for
WCAG 2.1 AA issues, stores the results inside Drupal as content, and reports
accessibility compliance over time — so your content team can find and fix
accessibility problems right where they work, before those problems go live.

Unlike an accessibility "overlay" that claims one‑click compliance but hides the
real issues, this module surfaces the underlying problems and gives editors clear
remediation guidance. Alfa runs client‑side against a page, then posts its
findings back to Drupal, where they are stored as custom entities: an `alfa_scan`
(a scan of a page), `occurrence` records (individual issue occurrences), and
`daily_stats` (aggregated conformance numbers rolled up by a cron job). Rule
metadata is modelled as a `siteimprove_accessibility_rules` taxonomy. Editors can
preview and auto‑scan a node from its edit form and see its dashboard inline, and
admins get a compliance‑history dashboard and issue‑reporting view under
`/admin/reports/siteimprove_accessibility`, plus an Alfa Scan collection at
`/admin/content/alfa-scan`.

This module is **not** the same as the classic `siteimprove` module: that one
provides the multi‑product Siteimprove sidebar (Accessibility, QA, SEO, Policies)
during editing, while this one is accessibility‑only and uses Siteimprove's latest
automated engine to highlight and remediate issues in the editor. The two are
complementary and can run side by side.

It needs a bit of setup to be useful: it depends on core's **REST** and
**Language** modules, and after enabling it you grant its permissions, configure
the checker on its settings form, and enable the REST resources that carry scan
data. There are no submodules.

On access control, the posture is sound: all the admin and reporting routes are
permission‑gated; the `save-scan` REST resource that receives Alfa's findings uses
cookie authentication (so Drupal's CSRF token applies) plus the standard
per‑resource REST permission; and the scan entities' access handler grants them
only to holders of the module's permissions. There are no anonymous mutation
endpoints.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (with core REST and Language).
2. [Configuration](configuration/index.md) — grant permissions, set the scan
   options, and enable the REST resources.

## Where it lives in the admin menu

- **Settings:** `/admin/config/siteimprove_accessibility/settings`.
- **Compliance dashboard & issue reporting:**
  `/admin/reports/siteimprove_accessibility`.
- **All scans:** the Alfa Scan collection at `/admin/content/alfa-scan`.

Editors also scan pages directly from a node's edit form.
