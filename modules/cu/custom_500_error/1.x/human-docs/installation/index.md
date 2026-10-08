# Installation

## Requirements

- **Drupal 8.8 or newer, through 11** (`core_version_requirement:
  ^8.8 || ^9.0 || ^10 || ^11`).
- No contrib module dependencies, and no third‑party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_500_error -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/custom_500_error -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_500_error -y
```

## Verify it worked

Open the module's settings, set a custom 500 message and markup, and save. Then,
in a non‑production environment, trigger or simulate a server error and confirm
your custom page appears in place of Drupal's bare default — and that it contains
no stack traces or other diagnostic detail.
