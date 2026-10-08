# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- The **Purge** module at **`^3.0.0`** (`drupal/purge`), set up and working —
  see the [Purge documentation](https://www.drupal.org/project/purge) for the
  full pipeline. Purge is pulled in automatically as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/purge_control -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/purge_control -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purge_control -y
```

## Verify it worked

1. Go to **Configuration → Development → Performance → Purge → Purge control**
   (`/admin/config/development/performance/purge/purge-control`) and confirm the
   settings form loads.
2. Check the Drush commands are available:

   ```bash
   drush pc --help
   ```

   You should see the `pc` command with its `enp` / `disp` / `ena` / `disa`
   subcommands. See [Configuration](../configuration/index.md) for what each
   does.
