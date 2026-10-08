# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) — the only dependency, enabled on any standard
  Drupal site.

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_display_title -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_display_title -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_display_title -y
```

## Verify it worked

Visit **Configuration → Content authoring → Node Display Title**
(`/admin/config/content/display-title-settings`). You should see a list of content
types to enable. Enable one, grant yourself the *access display title field*
permission, then edit a node of that type — a **Display title** field should appear.
See [Configuration](../configuration/index.md) for the full walkthrough and the
permission model.
