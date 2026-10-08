# Config Import (confi) — manual setup guide

**Config Import** (project `confi`, **machine name `config_import`**) is a
developer tool for importing Drupal configuration *granularly* — one config item
at a time — instead of core's all-or-nothing `drush config:import`. During active
development, importing all config at once is inconvenient and risky: it can
overwrite or delete config or content you didn't mean to touch. Config Import lets
you import just the specific config you need, typically from within an
`hook_update_N()` update hook, so a deployment applies exactly the changes you
intend.

Everything happens through a service, `config_import.importer`. In code you fetch
the service and call `importConfigs([...])` / `exportConfigs([...])` with the
config names you care about; by default it uses the sync directory, but you can
point it at any directory. It also integrates with the **Features** module (via a
`config_import.features_importer` service, once Features is enabled) and ships
Drush commands — run `drush help --filter=config_import` to list them.

> **Important — note the naming.** The Composer package is `drupal/confi`, but the
> module you enable is **`config_import`**. Use `composer require drupal/confi`
> and `drush en config_import`.

This is a *consequential developer tool*: importing configuration can change
permissions, roles, fields, and access rules, so a granular importer also makes it
easier to import the *wrong* thing. Restrict its use to trusted developers/admins,
review what an import will change, and treat every import as a deliberate
deployment step — the blast radius of a bad import is site-wide.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (as
   `drupal/confi`) and enable the module (as `config_import`).

There is **no configuration page** — Config Import is used from code (update
hooks) and via its Drush commands, described below.

## How to use it

- **In an update hook**, fetch the service and import specific config:

  ```php
  /** @var \Drupal\config_import\ConfigImporterServiceInterface $importer */
  $importer = \Drupal::service('config_import.importer');
  // Optionally point at a different directory:
  // $importer->setDirectory('/var/config');
  $importer->importConfigs(['core.extension']);
  ```

- **With Features** (enable `features` first), use
  `\Drupal::service('config_import.features_importer')->importFeatures(['my_feature'])`.
- **From Drush**, list the commands with `drush help --filter=config_import`, then
  `drush help COMMAND_NAME` for details on any one.
