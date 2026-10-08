# Installation

## Requirements

- **Drupal 10.1 or newer** (`core_version_requirement: >=10.1`).
- Used in combination with the **Symfony Messenger + Drupal** project (`sm`),
  which provides the message bus this module schedules onto.
- Non-Drupal dependencies are managed by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/sm_scheduler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sm_scheduler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sm_scheduler -y
```

## What next

Set up your recurring schedules following the module's README so that Symfony
Messenger messages are dispatched cron-like. Make sure the `sm` (Symfony
Messenger) module is installed and a consumer is running to process the
dispatched messages.
