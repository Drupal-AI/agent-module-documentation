# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core only — no other modules, no Composer libraries, no PHP requirements.
- Comfort editing your theme's **Twig templates**: this module has no GUI, so you add
  the pager in code.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_entity_pager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_entity_pager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_entity_pager -y
```

## Verify it worked

Enabling the module makes its Twig pager function available but changes nothing on its
own. Add the function to a node template and rebuild caches (see
[How to use it](../index.md#how-to-use-it)), then view a node of that type — you
should see previous/next links rendered by the pager.
