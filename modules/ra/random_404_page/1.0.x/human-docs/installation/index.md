# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules, PHP extensions, or third-party libraries are required — it
  builds entirely on core's error-page handling.

## Install with Composer

From the project root:

```bash
composer require drupal/random_404_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/random_404_page -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en random_404_page -y
```

No new permission is created — configuring the error pages reuses core's
**Administer site configuration** permission, which administrators already hold.

## Verify it worked

Go to **Configuration → System → Basic site settings**
(`/admin/config/system/site-information`). Where core normally shows a single
"Default 404 page" and "Default 403 page" field, you should now see two multi-line
**404 pages** and **403 pages** text areas. If they are there, the module is
active — head to [Configuration](../configuration/index.md) to fill them in.
