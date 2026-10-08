# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **System** module (`system`) — always present in a Drupal install.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/route_title_updater -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/route_title_updater -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en route_title_updater -y
```

## Permissions

The module provides its own permission for managing route title overrides. Grant
it only to trusted administrators at **People → Permissions**, since changing page
titles affects SEO and how pages present to visitors.

## Verify it worked

After enabling, click the module's **Configure** link. You should see a listing of
the routes on your site that have a title, ready to be overridden. If that listing
loads, the module is installed correctly — see "How to use it" on the
[overview page](../index.md).
