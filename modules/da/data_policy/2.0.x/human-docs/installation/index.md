# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Module dependencies:** core **Block** (`block`) and **Path Alias**
  (`path_alias`) — both enabled automatically as dependencies.

> **Read the compatibility warning first.** On a clean Drupal 11 install, enabling
> Data Policy has been observed to break the `module_installer` service (a circular
> service reference), after which `drush pm:*` commands vanish and **no module can
> be installed or uninstalled — including this one** — until `data_policy` is
> removed by hand from `core.extension`. Install on a disposable environment first
> and confirm `drush pm:list` still works before relying on it. See the
> [overview page](../index.md) for the full description and recovery steps.

## Install with Composer

From the project root:

```bash
composer require drupal/data_policy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/data_policy -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en data_policy -y
```

Core's Block and Path Alias modules are enabled automatically as dependencies.

> **After enabling, sanity‑check the installer service** before doing anything
> else: run `drush pm:list` (or another `drush pm:*` command). If it errors with a
> circular‑reference message, you have hit the compatibility issue described on the
> overview page — recover by removing `data_policy` from `core.extension` and
> rebuilding caches.

## Submodules

- **Data Policy Export** (`data_policy_export`) — produces a user's consent record
  on request, which is what a GDPR subject access request needs. Enable it only if
  you need that export capability:

  ```bash
  drush en data_policy_export -y
  ```

## Verify it worked

Log in as an administrator and open the Data Policy configuration (the inform
blocks collection it links to, and the Data Policy screens). If you can reach the
screens to create a policy, the module is installed — proceed to
[Configuration](../configuration/index.md).
