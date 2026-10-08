# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Service** module (`service`) — a required dependency. Composer pulls it in
  automatically when you require this module, and Drupal enables it as a
  dependency when you turn StandWithUkraine on.

## Install with Composer

From the project root:

```bash
composer require drupal/standwithukraine -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required Service module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/standwithukraine -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en standwithukraine -y
```

Drupal enables the required Service module automatically as a dependency.

## Verify it worked

Visit your site's front end — you should see the Ukraine support message and the
flag-color image styling. If you want to control who can work with the
support-message display, review the module's permission at **People → Permissions**
(`/admin/people/permissions`).
