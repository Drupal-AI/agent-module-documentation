# Multisite Manager Tool — manual setup guide

**Multisite Manager Tool** (`multisite_manager_tool`) is an administration helper
for running a **Drupal multisite installation** — the setup where one codebase
serves several sites from separate `sites/*` directories. Instead of jumping
between shells and settings files, it gives you a single admin page to handle the
routine cross‑site chores. From there you can detect and list all active sites,
clear the cache for one site or for every site at once, and create a brand‑new
site (generating its directory, settings file, and — where the database user has
permission — its database).

It also treats each site as a **configuration entity**, so site definitions are
exportable with the rest of your config and are exposed through **JSON:API** —
handy for a headless front end that needs to discover which sites exist. For that
headless case you can register both a backend and a frontend URL per site. When
you install the module onto a multisite that already has several sites, a
**reconciliation** step detects and registers the existing sites for you.

This is a **high‑privilege** capability: its actions can affect several sites at
once, so the permission it provides concentrates real risk. Grant it only to
fully trusted administrators, and make sure the database user configured for the
site has the rights it needs before you rely on the "create database" feature.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the management page, its actions,
   and the access considerations that come with them.

## Where it lives in the admin menu

After enabling, the tool lives at **Configuration → System → Multisite Manager**
(`/admin/config/system/multisite-manager`). That page is where you list sites,
clear caches, create new sites, and manage site definitions.
