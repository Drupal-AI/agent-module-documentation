# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- The **Sites** module (`sites`) and the **RobotsTxt** module (`robotstxt`) — both
  hard dependencies.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sites_robotstxt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Sites and RobotsTxt
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sites_robotstxt -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sites_robotstxt -y
```

This also enables Sites and RobotsTxt as dependencies if they are not already on.

## Verify it worked

Visit `/admin/config/search/sites-robotstxt` as a user with the
`administer robots.txt` permission — the global settings form should load. Then
edit one of your sites and confirm it has a **"Site specific robots.txt
additions"** field. See [Configuration](../configuration/index.md).
