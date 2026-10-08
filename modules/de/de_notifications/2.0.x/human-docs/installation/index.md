# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Dynamic Entity Reference** (`dynamic_entity_reference`) module — required,
  and pulled in by Composer.
- If you plan to send notifications by email using the bundled **Decoupled Email
  Notifications Symfony Mailer** (DENSM) submodule, you'll also need the
  **Symfony Mailer** module installed.

There are no additional PHP or front-end library requirements declared by the
module.

## Install with Composer

From the project root:

```bash
composer require drupal/de_notifications -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Dynamic Entity
Reference and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/de_notifications -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en de_notifications -y
```

Drupal will enable Dynamic Entity Reference as a dependency if it isn't already on.

## Submodules

- **Decoupled Email Notifications Symfony Mailer** (DENSM) — bundled with DEN, this
  lets you use Symfony Mailer as a notification type. Enable it from **Extend**
  (`/admin/modules`), or with `drush en <machine_name> -y`, only if you want email
  delivery — and install the **Symfony Mailer** module alongside it. DEN's modular
  architecture means additional notification-type submodules can be built by
  developers as needed.

## Verify it worked

Confirm the module is enabled (`drush pml | grep de_notifications`) and that you
can reach the settings form at **`/admin/config/system/de_notifications`**. There
is still important setup to do before notifications flow — see
[Configuration](../configuration/index.md) for the secret key, cron jobs, and the
notifications field.
