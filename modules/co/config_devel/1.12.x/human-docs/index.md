# Configuration development — manual setup guide

**Configuration development** (`config_devel`) is a developer tool that automates
moving Drupal configuration between YAML files and the site's active configuration
store, and that exports a module's own configuration back into its `config/install`
directory — a Features-style workflow for Drupal 8 and later.

It does three related things:

1. **Automated import** — list config files, and at the start of every request the
   module checks each file's hash and, if it changed, imports it into active storage
   (exactly as if you had pasted it into core's *Single import* form). Great for
   iterating on a YAML file locally without clicking through the UI each time.
2. **Automated export** — list config object names, and whenever one of those objects
   is saved through the admin UI, its current value is written back out to the
   file(s) you specified, so your edits land straight in version control.
3. **Module (Features-like) export/import** — a module lists the config objects it
   owns in a `config_devel:` section of its `.info.yml`, then a Drush command writes
   those objects into the module's `config/install` (and `config/optional`)
   directory, or reads them back into active storage.

> **Important:** This is a **development-only** tool. Do not deploy it to production,
> exercise caution, and always work under version control. Automated import runs on
> every request and will overwrite active config from files.

The module depends only on core's **Configuration Manager** (`config`). It has no
permissions of its own — its settings form is gated by the core *Import
configuration* permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (on development environments only).
2. [Configuration](configuration/index.md) — set up auto-import and auto-export, use
   the module export/import via a `.info.yml` section, and the Drush commands.

## Where it lives in the admin menu

Configuration development's settings form is at **Configuration → Development →
Configuration development** (`/admin/config/development/config_devel`). The
Features-style module export/import is done from the command line with Drush.
