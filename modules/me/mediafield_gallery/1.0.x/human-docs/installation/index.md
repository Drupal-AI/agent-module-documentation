# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1** or newer (`php_requirement: 8.1`).
- Core's **Views**, **Media**, and **Field** modules enabled (all ship with Drupal
  core).
- A **media reference field** (Entity Reference → Media) already configured on the
  content type whose media you want to show as a gallery. The module needs a
  properly configured media reference field to work.

There are no third‑party Composer or PHP library requirements. Note the module is
**not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/mediafield_gallery -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mediafield_gallery -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mediafield_gallery -y
```

## Verify it worked

Go to **Configuration → Media → Media Field Gallery**
(`/admin/config/media/mediafield-gallery`). If the settings form loads and lists
your media field(s), the module is installed. Configure it (see
[Configuration](../configuration/index.md)), clear the cache, and check the target
View path to confirm the gallery renders.
