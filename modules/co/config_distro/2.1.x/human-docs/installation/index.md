# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Configuration Manager** module (`config`) enabled — Drupal enables it
  automatically as a dependency.
- The **Config Filter** module (`drupal/config_filter`) — a hard Composer
  dependency, pulled in automatically.
- **Drush 11 or newer** is *suggested* (`drush/drush >=11`). It isn't strictly
  required to enable the module, but the `config-distro-update` command only
  exists when Drush is present. If you plan to apply updates through the UI only,
  you can skip it.
- **A companion module to populate the distribution storage** — most commonly
  [Configuration Synchronizer](https://www.drupal.org/project/config_sync)
  (`config_sync`). Config Distro is a framework and does nothing useful on its
  own; without a companion, the update screen and Drush command report no
  changes. This is not enforced as a dependency, but you will want one.

## Install with Composer

From the project root:

```bash
composer require drupal/config_distro -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Config Filter.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_distro -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_distro -y
```

After enabling, grant the **Synchronize distro configuration** permission
(`synchronize distro configuration`) to the roles that should be allowed to
review and import distribution updates — it is security-sensitive, so keep it to
trusted administrators. You'll also want to enable a companion such as Config Sync
so there is something to import.

## Submodules — enable only what you need

Config Distro ships two optional submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Config Distro Ignore** | `config_distro_ignore` | Lets you retain specific configuration during distribution imports, so your site's customizations aren't overwritten by an update. This is the one most sites will want. |
| **Config Distro Filter** | `config_distro_filter` | A **deprecated** bridge that runs [Config Filter](https://www.drupal.org/project/config_filter) plugins during the transform step. Only enable it if you have an existing setup that relies on it. |

Enable a submodule with `drush en`, for example:

```bash
drush en config_distro_ignore -y
```
