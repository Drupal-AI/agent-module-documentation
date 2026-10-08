# Installation

## Requirements

Scheduler for ECK is a bridge, so it needs both modules it connects:

- **Drupal 8.8.3, 9, 10, or 11** (`core_version_requirement: ^8.8.3 || ^9 || ^10 || ^11`).
- **PHP 7.1 or newer.**
- The **[Scheduler](https://www.drupal.org/project/scheduler)** module,
  version **2.0.0-rc4 or newer** (`scheduler`).
- The **[Entity Construction Kit (ECK)](https://www.drupal.org/project/eck)**
  module (`eck`).

Both Scheduler and ECK must be present and enabled for this module to do
anything. There are no third-party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/scheduler_eck -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
shared dependencies (including Scheduler and ECK if they are not already
required).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scheduler_eck -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scheduler_eck -y
```

Drupal will enable Scheduler and ECK as dependencies if they are not already on.

## Verify it worked

Edit one of your ECK bundles (or open the Scheduler settings form). If the module
is working, you will see Scheduler's **publish-on** / **unpublish-on** options
available for that ECK entity type, just as they appear for content types. Turn
them on, then edit an ECK entity and you should see Scheduler's date fields on the
edit form. See the [main guide](../index.md) for the full "how to use it" steps.
