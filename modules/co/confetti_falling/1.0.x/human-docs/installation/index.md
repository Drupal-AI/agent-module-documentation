# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).

There are no module dependencies and no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/confetti_falling -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/confetti_falling -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en confetti_falling -y
```

## Verify it worked

Go to `/admin/config/confetti_falling_settings`, set the trigger **class name**,
save, and clear the cache. Visit a page that contains that class — the falling
confetti animation should play.
