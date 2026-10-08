# Installation

## Requirements

- **Drupal 9.3+, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Node** module (`node`) enabled — part of any standard install.
- Working **cron**, only if you want to use the optional key auto‑regeneration.

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_authlink -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_authlink -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_authlink -y
```

Enabling the module does not turn authlinks on for any content yet — that's a per‑content‑type
choice. Head to [Configuration](../configuration/index.md) to enable it where you want it and to
review the important security notes before sharing any links.
