# Migration Hbk Auto — manual setup guide

**Migration Hbk Auto** (`migration_hbk_auto`) is a guided tool for importing
content structure and content from a **Drupal 7** site into a Drupal 10/11 site.
It ships a Vue.js single-page admin interface that walks you through the
migration: load the entities from your D7 source, list their bundles, check that
the matching fields and configuration exist on the new site, generate any missing
fields, and then import the content in paginated passes.

Behind the interface, a set of controller endpoints do the work — generating
Drupal field storage and instances from the D7 field data, importing files by
their D7 file ids, checking which taxonomy terms already exist, and writing or
verifying configuration entities. You tell the module where to fetch data from by
setting the URL of your Drupal 7 source site on a small settings form. On the D7
side, the source site needs the **migrateexport** module installed so the data can
be read.

Needs configuration before it does anything: at minimum you must set the D7 source
site URL (see [Configuration](configuration/index.md)). It depends on Drupal
core's **Migrate** module, and in practice pulls in the wider migration toolchain
(Migrate Plus, Migrate Tools, Migrate Upgrade, and Views Migration) via Composer.

> **Important security note.** This is an administrative developer tool that
> creates fields, creates file entities, and writes configuration — but several of
> its action endpoints are gated only by the *access content* permission, which is
> granted to anonymous users by default. **Lock these routes down before you use
> the module on any reachable site** (for example on a local/offline build, or by
> restricting the routes' access), and remove or disable the module once your
> migration is complete. The interface also loads the Vue library from an external
> CDN. Treat this module as something you run in a controlled environment, not on a
> live public site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and get the wider migration toolchain in place.
2. [Configuration](configuration/index.md) — set the Drupal 7 source site URL.

## Where it lives in the admin menu

- The settings form is at **Configuration → System → Migration settings**
  (`/admin/config/system/migration-settings`), where you enter the D7 source URL.
- The import interface is at
  `/admin/migration-hbk-auto/import-from-d7` — the Vue.js single-page app that
  drives the migration steps.

## How to use it

1. On the Drupal 7 source site, install the **migrateexport** module.
2. In Drupal, set the D7 source site URL on the settings form (see
   [Configuration](configuration/index.md)).
3. Go to the import page (`/admin/migration-hbk-auto/import-from-d7`) and click
   **Load all entities** to list the entities from your D7 site as an accordion.
4. Expand an entity, click **List bundles**, then expand a bundle and click
   **Check configuration** to get a mini-report: how many items there are to
   import, the fields on the D7 side, the fields on the D10/11 side, and any that
   are missing.
5. If fields are missing, click **Re-import all fields** to generate them.
6. Fill in the import form (pagination length, pagination start, and whether to
   continue on error) and click **Import contents**.
7. Use **Content management** to re-import individual instances when you don't want
   to overwrite everything you've already imported.

Because the mutating endpoints are only gated by *access content*, do all of this
on a locked-down or offline build.
