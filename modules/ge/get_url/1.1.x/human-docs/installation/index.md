# Installation

## Requirements

- **Drupal 8 through 12** (`core_version_requirement: ^8 || ^9 || ^10 || ^11 || ^12`).
- No other modules, PHP extensions, or third‑party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/get_url -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/get_url -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en get_url -y
```

## Verify it worked

Add `{{ get_url(1) }}` to any Twig template (for example your page template) and
reload a page. If it prints the URL of node 1, the `get_url()` function is
registered and working. Remove the test line afterwards.
