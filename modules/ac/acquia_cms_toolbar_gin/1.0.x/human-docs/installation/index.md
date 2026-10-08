# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Acquia CMS Toolbar** (`acquia_cms_toolbar`) — Drupal enables it automatically
  as a dependency (which in turn brings in Admin Toolbar).
- The **Gin** admin theme (`drupal/gin`) installed and set as the administration
  theme. This module exists to make the toolbar work under Gin, so Gin is what
  makes it useful.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_toolbar_gin -W
```

If Gin is not already present, add it too:

```bash
composer require drupal/gin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in and update shared
dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_cms_toolbar_gin -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_toolbar_gin -y
```

Then set Gin as the administration theme at **Appearance**
(`/admin/appearance`) if you have not already — install Gin, then use its
"Set as administration theme" link.

## Verify it worked

Log in as an administrator with Gin as your admin theme. The Acquia CMS admin
toolbar should render cleanly within the Gin interface, with no styling clashes.
