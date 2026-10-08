# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No dependencies and no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/better_page_not_found -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_page_not_found -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_page_not_found -y
```

Once enabled, the improved styling applies to the 404, 403, and error pages. Visit
a non‑existent URL on your site to confirm you get the styled not‑found page.
