# Jouve Project Version — manual setup guide

**Jouve Project Version** (`jouve_project_version`) tracks and displays the
**version/release of your project** — the codebase itself, not Drupal core or
contrib modules. It reads a version file kept in your project's Composer root and
surfaces that value in Drupal, so your team can see at a glance which version of the
site is deployed. That's handy for support ("what version are you running?") and for
release verification after a deployment.

It's a small administration / DevOps helper with no dependencies beyond Drupal core.
The version is displayed on the standard **status report**.

One thing to keep in mind: a deployed version or release identifier is operational
metadata that you may not want to advertise publicly. The status report is already
an administrators‑only page, so keep the display appropriately admin‑gated.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no dedicated settings form — you manage the version through a
version file in your project's Composer root, and it displays on the status report.

## Where it lives in the admin menu

After enabling, the project version appears on the **Status report** at **Reports →
Status report** (`/admin/reports/status`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Maintain a **version file in your project's Composer root** that holds the
   current project version/release — typically updated as part of your release or
   deployment process.
3. Visit **Reports → Status report** (`/admin/reports/status`) to see the version
   Drupal is reporting, and use it to confirm a deployment landed the version you
   expected.
