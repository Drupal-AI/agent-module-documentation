# Jelastic Info — manual setup guide

**Jelastic Info** (`jelastic_info`) is an admin‑facing dashboard for sites hosted
on the **Jelastic / Virtuozzo Application Platform**. It reads your hosting
environment's state from the Jelastic Platform API and surfaces it right inside
Drupal, so an operator can answer "where is this site running, and what shape is
the box in?" without leaving the admin.

It presents, at **Reports → Jelastic environment**:

- an **environment summary** — display name, domain, status (Running / Sleeping /
  Migrating / Broken), hardware node group, and SSL/HA flags;
- a **per‑node table** — group, name, internal IP, cloudlets allocated
  (fixed/flexible), memory, and disk limit;
- **resource usage** over the last hour — average CPU, cloudlets used, IOPS, disk
  I/O, and network in/out.

It also adds a row to the standard status report at **Reports → Status report**
so environment state shows at a glance, with the severity reflecting the
underlying status (Running is OK, Sleeping is informational, transitioning states
warn, Down/Broken is an error). For developers, it exposes a read‑only snapshot
service (`jelastic_info.snapshot`) and a refresh event, but that's an API detail
rather than something you click.

Connecting the dashboard requires a **Personal Access Token** from your Jelastic
dashboard. Version 1.0 is read‑only — it never restarts containers or changes your
environment.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Jelastic Personal Access
   Token, pick the environment, and test the connection.

## Where it lives in the admin menu

The dashboard is at **Reports → Jelastic environment** (`/admin/reports`), and a
summary row appears on the **Status report** (`/admin/reports/status`). Access is
governed by two permissions: **Administer Jelastic info** (`administer jelastic
info`) for configuring the connection, and **View Jelastic info** (`view jelastic
info`) for reading the dashboard.
