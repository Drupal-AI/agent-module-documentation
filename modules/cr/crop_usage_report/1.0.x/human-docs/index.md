# Crop Usage Report — manual setup guide

**Crop Usage Report** (`crop_usage_report`) is an auditing tool for sites that rely
on the Crop / Image Widget Crop workflow. Editors are supposed to apply crops to
their media images, but on a large project it's easy for some images to slip through
uncropped — and Image Widget Crop doesn't offer a usage report to catch them. This
module fills that gap: it scans your media image entities and reports which ones are
missing manually-applied crop types.

The heart of the module is an admin report page that lists media images along with
their crop coverage, and lets an editor **filter** to find images missing multiple
crops or specific crop types. You can also **export the results as CSV** for
tracking or sharing. It's a straightforward quality-assurance aid — no content is
changed, it simply surfaces what still needs cropping.

The module depends on core **Media** (`media`) and **File** (`file`) plus the
**Crop** module (`crop`), and it expects **Image Widget Crop** to be installed,
enabled, and configured for your media images (that's the workflow it audits). It
requires Drupal 11 and defines two permissions: *view crop usage report* (to see the
report) and *administer crop usage report* (to manage it).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module along with its Media, File, and Crop dependencies.

The report and its options live in the admin UI, described under "How to use it"
below.

## Where it lives in the admin menu

- The report itself is at **Reports → Crop usage** (`/admin/reports/crop-usage`),
  with a CSV export at `/admin/reports/crop-usage/export`.
- Report configuration is at **Configuration → Media → Crop usage report**
  (`/admin/config/media/crop-report`).

## How to use it

1. Make sure **Image Widget Crop** is installed, enabled, and configured for your
   media images — that's the crop workflow this report audits.
2. Grant the **view crop usage report** permission to the roles that should see the
   report, and **administer crop usage report** to those who should manage it
   (**People → Permissions**).
3. Go to **Reports → Crop usage** (`/admin/reports/crop-usage`). You'll see your
   media images with their crop coverage. Use the filters to narrow down to images
   missing specific crop types or missing multiple crops.
4. Click through to the export (`/admin/reports/crop-usage/export`) to download the
   filtered results as a CSV.
5. Visit **Configuration → Media → Crop usage report**
   (`/admin/config/media/crop-report`) to adjust the report's configuration.
