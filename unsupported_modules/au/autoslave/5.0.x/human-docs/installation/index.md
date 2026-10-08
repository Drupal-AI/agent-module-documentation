# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **System** module (always present).
- Working **database replication** at the infrastructure level — one or more
  replica database servers that AutoSlave can route reads to. The module does not
  create replicas; it only directs queries to replicas you have already set up.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/autoslave -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autoslave -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autoslave -y
```

There is no admin settings form. The read/write splitting is driven by the
replica database connections you define in your site's **`settings.php`** — see
[How to use it](../index.md#how-to-use-it) on the overview page. Make sure your
replicas are running and reachable before you route live traffic to them.
