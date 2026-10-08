# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's **Configuration Translation** module (`config_translation`), enabled
  automatically as a dependency — this module extends it.

There are no third-party Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_translation_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_translation_access -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_translation_access -y
```

There are no submodules and no settings form.

## Next steps

Enabling the module simply makes the new **Translate editable configuration**
permission available. Assign it as described in **How to use it** on the
[overview page](../index.md).
