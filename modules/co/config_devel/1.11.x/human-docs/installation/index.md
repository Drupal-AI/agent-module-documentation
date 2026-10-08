# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Configuration Manager** module (`config`) — a dependency, enabled on
  standard installs.
- No third-party libraries.

> **Development only.** Config Devel is a developer/local tool. Install it in your
> local or development environment, not on production.

## Install with Composer

From the project root — typically as a dev dependency:

```bash
composer require --dev drupal/config_devel -W
```

(You can drop `--dev` if your workflow doesn't separate dev requirements, but
keeping it out of production is the point.) The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require --dev drupal/config_devel -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_devel -y
```

There are no submodules.

## Permission

The module defines no permission of its own. The settings form is gated by core's
**Import configuration** permission, so grant that (or use an administrator
account) to reach it.

## Next step

See the module [overview](../index.md#how-to-use-it) for the auto-import /
auto-export settings and the `cde` / `cdi` / `cdi1` Drush commands.
