# Image style usage — manual setup guide

**Image style usage** (`image_style_usage`) answers a question every long‑lived
site eventually asks: *where is this image style actually used, and which styles
can I safely delete?* It builds a single report that lists every place each image
style — and each responsive image style — is referenced across all **entity view
displays** and all **Views**, and it collects the styles that nothing references
into a separate **Unused image styles** table.

Each usage row links straight to the relevant view‑display or Views edit form, so
you can jump from "this style is used here" to the exact configuration in one
click. The unused list lets you clean up orphaned styles with confidence. It's a
read‑only auditing tool — it makes no changes to your configuration.

One limitation to keep in mind: the report scans **configuration** (view displays
and Views), not your code or Twig templates. If an image style is referenced
directly in a custom module or theme template, it won't appear here — so a style
listed as "unused" may still be used from code. The report requires the
**Administer image styles** permission and has no dependencies beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no settings form** — the module simply adds a report page, described in
"How to use it" below.

## Where it lives in the admin menu

The report is at **Configuration → Media → Image styles → Usage**
(`/admin/config/media/image-styles/usage`), alongside the core image‑styles
screen. Viewing it requires the **Administer image styles** permission.

## How to use it

1. Go to `/admin/config/media/image-styles/usage` (or open the **Usage** tab from
   the Image styles page).
2. Read the usage tables: each image style and responsive image style is listed
   with every entity view display and Views field that references it. Click a
   usage to open the relevant edit form.
3. Scroll to the **Unused image styles** table to see styles referenced nowhere in
   configuration.
4. Before deleting any style there, **double‑check your custom code and Twig
   templates** — the report does not scan them, so confirm the style isn't
   referenced directly before removing it.
