# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Menu UI** module (`menu_ui`) — Drupal enables it automatically as a dependency.

There are no contrib or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/footermap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/footermap -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en footermap -y
```

There is no settings form and no submodules. After enabling, place the **Footermap** block
(in the *Sitemap* category) from **Structure → Block layout** and configure it — see
[Configuration](../configuration/index.md).
