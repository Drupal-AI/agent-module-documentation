# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies.
- An external **log-receiving endpoint** that accepts HTTP POST, plus any
  authorization token it requires.

## Install with Composer

From the project root:

```bash
composer require drupal/push_logs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/push_logs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en push_logs -y
```

## Verify it worked

1. Open the module's settings page under **Configuration** and confirm it loads.
2. Configure a receiving host (and authorization, if needed) as described in
   "How to use it" in the [overview](../index.md).
3. Trigger a log entry in Drupal and confirm the corresponding HTTP POST reaches
   your external log service.
