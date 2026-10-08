# Installation

## Requirements

- **Drupal 8 through 15** (`core_version_requirement: ^8 || ^9 || ^10 || ^11 || ^12 || ^13 || ^14 || ^15`).
- No module dependencies and no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/druhels -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/druhels -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

Often you will not require it directly at all — if another module depends on Drupal
Helpers, Composer installs it automatically as a dependency.

## Enable the module

```bash
drush en druhels -y
```

## Verify it worked

There is nothing visible to check in the UI. Confirm the module is enabled
(**Extend**, or `drush pml | grep druhels`), and its helper classes are then
available to call from your code.
