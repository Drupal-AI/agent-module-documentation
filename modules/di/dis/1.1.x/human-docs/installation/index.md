# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core only — there are no module dependencies and no PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dis -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dis -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dis -y
```

## Verify it worked

Go to **Reports → Status report** (`/admin/reports/status`). If your site has no
deployment identifier set, you will now see a warning about it there. Set the value
in `settings.php` (see the "How to use it" section of the [overview](../index.md))
and reload the report — the warning should clear.
