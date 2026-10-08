# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **[Migrate Plus](https://www.drupal.org/project/migrate_plus)**
  (`drupal/migrate_plus ^6.0`) and core's **Migrate** module.
- **[Redirect](https://www.drupal.org/project/redirect)**
  (`drupal/redirect ^1.11`) — required because the module can create URL redirects for
  migrated content automatically.
- The **QueryPath** library (via the QueryPath module or a standalone install) is
  needed if you use the **Obtainer** / HTML‑scraping features.

Composer pulls in Migrate Plus and Redirect for you.

## Install with Composer

From the project root:

```bash
composer require drupal/migration_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the dependencies and
update any shared ones as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migration_tools -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migration_tools -y
```

## Submodule — the example

| Submodule | Machine name | What it provides |
|---|---|---|
| **Migration Tools Example** | `migration_tools_example` | Runnable example migrations that demonstrate the toolkit — the fastest way to learn it. |

Enable it if you want the worked examples:

```bash
drush en migration_tools_example -y
```

You don't need the example for a real project — enable just the base module and use
its plugins and classes from your own migrations. Next, the optional debug settings
are at [Configuration](../configuration/index.md).
