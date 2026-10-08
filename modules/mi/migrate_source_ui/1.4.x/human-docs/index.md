# Migrate Source UI — manual setup guide

**Migrate Source UI** (`migrate_source_ui`) adds a simple admin screen for
**uploading a CSV, XML, or JSON file and running an existing migration against
it** — no Drush command or code needed to feed a migration its source data. It sits
on top of Drupal's core Migrate API and the contributed **Migrate Tools** module,
and it's aimed at the moment when a non-developer needs to re-run an import by
uploading a fresh export file.

The module does **not** define any migrations of its own. You still author the
migration itself (as configuration via **Migrate Plus**, or in a module); Migrate
Source UI only supplies the **source file at run time**. On its run page it lists
the migrations whose source plugin reads an uploaded file — CSV sources (via
**Migrate Source CSV**), JSON/XML URL sources (via **Migrate Plus**), and
spreadsheets (via **Migrate Spreadsheet**) — lets you pick one, upload a file,
optionally reset a stuck migration to Idle, and runs the import. It only accepts
the allowed extensions (`csv`, `json`, `xml`) and reports the migration's messages
back to you.

It becomes useful the moment you enable it and grant the right permissions — there
is just one optional setting (where uploaded files are stored). Two permissions gate
its two pages: one to run migrations and one to change the setting. Because running
a migration creates or overwrites content in bulk, treat access to the run page as
security-sensitive.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   add the source modules for the file types you need.
2. [Configuration](configuration/index.md) — grant the permissions and choose where
   uploaded files are stored.

## Where it lives in the admin menu

The **run page** — where you upload a file and run a migration — sits under
**Content → Migrate Source UI** (`/admin/content/migrate_source_ui`). The single
**settings page** sits under **Configuration → Content authoring → Migrate Source
UI** (`/admin/config/content/migrate_source_ui`).

## How to use it

Once you have authored a file-based migration and enabled the matching source
module, go to **Content → Migrate Source UI**. Pick your migration from the list
(each is labelled with the file type it supports), upload the source file, and
submit. The module saves the file, points the migration's source path at it, resets
the migration to Idle if it was stuck, and runs the import — showing you the
resulting messages. To inspect status afterward, use the Migrate Tools Drush
commands (`drush migrate:status`).
