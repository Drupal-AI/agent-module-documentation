# Digital Asset Inventory — manual setup guide

**Digital Asset Inventory** (`digital_asset_inventory`) is a site‑wide auditing
tool for every digital asset your Drupal site touches. It scans your content,
menus, and configuration and builds an inventory of all managed files, media
items, orphaned files that nothing references anymore, and external or embedded
links (Google Docs, YouTube, Vimeo, SharePoint, Qualtrics, and dozens of other
providers matched by their URLs). For each asset it records **where it is used**,
resolves a **human‑readable title**, and evaluates **accessibility signals** such
as alt text, captions, and subtitles. The results are browsable, filterable, and
exportable to CSV for remediation planning, with an at‑a‑glance dashboard.

The module was built with **ADA Title II** accessibility compliance in mind. On
top of the inventory it offers an optional **Archival Management System** — a
workflow for archiving legacy (pre‑deadline) content with a dated attestation, a
public archive registry page, and per‑item visibility control. These archive
features are turned **off by default**; you enable them on the settings form when
you need them.

Scans can be run from a form in the admin UI or from the command line with
`drush dai:scan`, which makes it easy to schedule or script. External page titles
are fetched safely (private and reserved IP addresses are rejected, and redirects
are re‑validated), so the title resolver won't be tricked into probing your
internal network. Access is controlled by seven granular permissions, so you can
give one role scanning rights, another deletion rights, and another the archival
records‑management role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (several
   dependencies) and enable it.
2. [Configuration](configuration/index.md) — the scanner, title‑resolution, and
   archive settings, the feature flags, and the permissions.

## Where it lives in the admin menu

The settings live under **Configuration → Accessibility → Digital Asset
Inventory** (`/admin/config/accessibility/digital-asset-inventory`). The inventory,
usage, and dashboard reports live under **/admin/digital-asset-inventory/…**. The
public archive registry (when enabled) is at `/archive-registry/{id}`.

## How to use it

1. Enable the module and its dependencies (see [Installation](installation/index.md)).
2. Run **Database updates** if prompted (`drush updb`) — the scanner guards on a
   database column.
3. Grant the appropriate permissions to your roles.
4. Run a scan — either from the Scan form or with `drush dai:scan` — then browse
   the inventory and dashboard, and export a CSV report.
5. Optionally enable the archive features in [Configuration](configuration/index.md)
   if you need the ADA Title II archiving workflow.
