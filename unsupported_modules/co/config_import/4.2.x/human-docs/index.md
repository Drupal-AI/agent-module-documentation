# Config Import — manual setup guide

**Config Import** (project **`confi`**, module **`config_import`**) is a
developer‑facing tool for importing and exporting a *chosen subset* of
configuration. Drupal's own config import is all‑or‑nothing against the sync
directory, which is too blunt when — say — an update hook just needs to bring in
exactly three config objects a module started shipping. This module wraps Drupal's
import machinery in a small service so you can move a named list of config objects
in or out.

Crucially it does a **real** import, not raw config writes: it's constructed with
the full set of collaborators an import needs — config storage and manager, UUID,
event dispatcher, lock, typed config, module handler and installer, theme handler,
file system and the extension lists — so imports honour dependencies and locking
rather than blindly overwriting records. A second service updates individual
parameters inside a config object, and a hook lets other modules add to the list
of configs involved.

Mind the **naming**: the drupal.org project is `confi`, but the module machine
name, its services and its namespace are all `config_import`. So you
`composer require drupal/confi` but `drush en config_import`.

This guide is written for a **human** developer. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (project `confi`) and enable it (`config_import`).

## How to use it

There is **no admin UI** — no settings page, routes or permissions. You use it from
code, typically an update hook or a deployment script, via the
`config_import.importer` service:

```php
function mymodule_update_10001() {
  $importer = \Drupal::service('config_import.importer');
  $importer->setDirectory(
    \Drupal::service('extension.list.module')->getPath('mymodule') . '/config/install'
  );
  $importer->importConfigs([
    'views.view.my_view',
    'core.entity_view_display.node.article.teaser',
  ]);
}
```

The service's methods are:

| Method | Purpose |
|---|---|
| `setDirectory($directory)` / `getDirectory()` | Point at (or read) the source directory the import reads from. |
| `importConfigs(array $configs)` | Import the named config objects. |
| `exportConfigs(array $configs)` | Export the named config objects. |

A second service, `config_import.param_updater`
(`ConfigParamUpdaterService`), updates a single parameter inside a config object —
handy for a small, targeted deployment change. And other modules can extend the
list of configs involved with `hook_config_import_configs_alter(array &$configs)`,
documented in the module's `config_import.api.php`.

> **⚠️ Importing overwrites.** Importing a config object that already exists
> replaces it — including any changes an editor made on the live site. List only the
> configs you actually intend to reset.

## Where it lives in the admin menu

Nowhere — Config Import provides no admin screens. It is used entirely from code
through the `config_import.importer` and `config_import.param_updater` services.
