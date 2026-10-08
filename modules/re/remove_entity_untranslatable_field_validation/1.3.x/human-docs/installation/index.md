# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules, PHP libraries, or third‑party requirements. It has no
  dependencies at all.

It is aimed at multilingual sites (ones running core's Content Translation), since
that is where the untranslatable-field constraint applies — but it does not *require*
those modules to be enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/remove_entity_untranslatable_field_validation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/remove_entity_untranslatable_field_validation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en remove_entity_untranslatable_field_validation -y
```

That is the entire setup. The moment it is enabled, the untranslatable-field
validation constraint is removed from every entity type site-wide. There is no
configuration form and there are no submodules.

## Verify it worked

After a cache rebuild (`drush cr`), edit a non-default translation of a node, change
a field that is **not** marked translatable, and save. Previously this failed with
*"Non-translatable field elements can only be changed when updating the original
language"*; now it saves successfully.

To turn the enforcement back on, uninstall the module — core's normal behavior
returns automatically.
