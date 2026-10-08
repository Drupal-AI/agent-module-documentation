# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No dependencies and no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/better_status_messages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_status_messages -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_status_messages -y
```

That is all — there is no configuration. Status, warning, and error messages now
appear in the styled, dismissible form. Trigger any message (for example by saving
a form) to confirm it works.
