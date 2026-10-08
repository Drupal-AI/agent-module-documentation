# Installation

## Requirements

Content Dashboard is lightweight and depends only on Drupal core:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No additional contrib modules, PHP extensions, or third‑party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/content_dashboard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_dashboard -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_dashboard -y
```

## Verify it worked

After enabling, grant the **access content dashboard** permission to at least one
role (see [Configuration](../configuration/index.md)), then log in as a user with
that role. You should see a **My Dashboard** link in the administration menu that
opens the dashboard with its Content, Media, and Configuration sections.
