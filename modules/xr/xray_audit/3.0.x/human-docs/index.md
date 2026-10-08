# Xray Audit — manual setup guide

**Xray Audit** (`xray_audit`) generates read-only **reports about how your Drupal
site is built** — its content model and entity architecture, content metrics,
display modes, views, installed modules and themes, database table sizes,
navigation, and access. The reports live under **Reports → Xray Audit Reports** and
each one can be exported to CSV, or all of them at once as a single ZIP. It's a
developer, analyst, or site-builder inspection tool — a fast way to understand an
unfamiliar site or produce an architecture snapshot for an audit or migration plan —
not a runtime feature your visitors ever see.

The reports are organized into groups (database, package, site structure, content
model, content metrics, forms, content display, layout, access control) with each
report computing a data table you can view on screen and download. Highlights
include an entity-architecture inventory (types, bundles, fields), node and
paragraph usage maps that show *where* each bundle is referenced, revision-bloat
detection, database table sizes flagged against a threshold, and an audit of which
admin views are exposed to anonymous users.

A small settings form lets you tune the thresholds used to flag "excessive" values —
node/paragraph revision counts and large database tables. Three Drush commands
expose node/paragraph usage counts and placement so you can script them, and an
optional **Xray Audit Insight** submodule turns selected findings into warnings on
Drupal's Status Report. The module is extensible through two plugin types (group and
task) so developers can add their own reports — see the [`agent/`](../agent/start.md)
docs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (and optionally the Insight submodule).
2. [Configuration](configuration/index.md) — the thresholds settings form, the
   views-report whitelist, cache handling, permissions, and the Drush commands.

## Where it lives in the admin menu

- **Reports → Xray Audit Reports** (`/admin/reports/xray-audit`) — the report home
  page and all report views. Gated by the **Xray Audit access** permission.
- **Configuration → Development → Xray Audit → Settings**
  (`/admin/config/development/xray_audit/settings`) — the thresholds form. Gated by
  the **Xray Audit administer configuration** permission.
