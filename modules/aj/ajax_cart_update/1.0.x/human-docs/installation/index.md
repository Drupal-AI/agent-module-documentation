# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- Core's **Views** module (`views`) — the Commerce cart form is a View. Drupal
  enables it automatically as a dependency.
- A working **Drupal Commerce** cart. This module enhances the Commerce cart
  form, so Commerce needs to be installed and in use for the module to do
  anything.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ajax_cart_update -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ajax_cart_update -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ajax_cart_update -y
```

That's all it takes. The cart form updates via AJAX immediately — there is no
required configuration.
