# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Drupal core's **Field** module (`field`) — part of core and enabled
  automatically as a dependency.
- No third-party PHP or JavaScript libraries.

> **Heads-up:** this module is **not** covered by Drupal's security advisory
> policy, and because it controls output markup you should grant access to the
> display settings only to trusted site builders.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_markup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_markup -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_markup -y
```

## Verify it worked

Go to a bundle's **Manage display** (**Structure → Content types → *(your type)* →
Manage display**). Its fields should now offer markup/wrapper options that let you
change the surrounding HTML per field and per view mode — set one, save, and view
the entity to confirm the rendered markup changed.
