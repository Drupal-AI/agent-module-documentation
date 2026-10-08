# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contributed **Scheduler** module (`scheduler`). Composer pulls this in as
  a dependency.
- Several core modules that the booking model builds on:
  **Content Moderation** (`content_moderation`), **Datetime** (`datetime`),
  **Node** (`node`), and **Workflows** (`workflows`), plus the supporting
  `field`, `menu_ui`, `options`, `path`, `taxonomy`, and `text` modules. Drupal
  enables these as dependencies.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/booking_scheduler -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer
install the Scheduler contrib dependency and update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/booking_scheduler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en booking_scheduler -y
```

Enabling it will also enable the Scheduler and core modules it depends on if they
are not already on. There are no submodules. After enabling, grant the module's
permissions and review the workflow/scheduling settings — see the
[overview](../index.md#how-to-use-it).
