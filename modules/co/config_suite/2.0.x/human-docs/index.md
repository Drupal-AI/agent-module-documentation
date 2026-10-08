# Config Suite — manual setup guide

**Config Suite** (`config_suite`) is a set of improvements to Drupal's core
configuration management, gathered behind a single administration screen. Core's
config workflow is a pair of commands (`drush cex` / `drush cim`) plus a synchronise
screen, and it assumes a discipline that real teams do not always keep: change
config, export it, commit it, import it elsewhere. The gaps are familiar — someone
changes a setting on production and forgets to export, so the next import silently
reverts it; a partial export is awkward, so a developer working on one feature
exports everything and produces a diff nobody can review; and nothing is automated,
so every step is a command somebody has to remember.

Config Suite tackles all three. Its headline features are:

- **Automatic configuration import** — update your sync folder (a `git pull`, say),
  then load a page as an admin and the configuration is imported for you. No `drush
  cim`. When no import is needed it stays fast.
- **Automatic configuration export** — save a form and the files in your config sync
  folder update automatically. The module listens for the config-save event and
  writes the change from the database out to the file system with no manual step.
- **Reuse configuration between sites** — import configuration created on one site
  into another with a different UUID, fixing the familiar *"Site UUID in source
  storage does not match the target storage"* error.

The whole feature set is gated behind the `administer config suite` permission, and
this is the 2.0.5 release for core 10.1+ or 11. It has no module dependencies beyond
core.

Two things are worth thinking about before you adopt any tool in this space, because
they matter more than the tool itself. First, **automating export changes what a diff
means**: once config is exported automatically, the diff stops being a record of
*deliberate* change and becomes a record of *everything*, accidents included — so the
review step effectively moves from "export" to "commit", and someone still has to be
doing that review. Second, **the most durable answer to configuration drift is
usually making production config read-only** (for example with the `config_readonly`
module) rather than better export tooling — that removes the whole class of problem
instead of managing it. Reach for automation like Config Suite where the team
genuinely cannot lock production down; reach for the lock where it can.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the Config Suite settings screen and
   how the automatic import/export behaviour is controlled.

## Where it lives in the admin menu

Once enabled, Config Suite's settings sit at **Configuration → Config Suite**
(`/admin/config/config_suite/admin_settings`), behind the `administer config suite`
permission.
