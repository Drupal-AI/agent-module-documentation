# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement:
  ^9 || ^10 || ^11 || ^12`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal enables it automatically as a dependency when you turn on
  Layout Builder Additions.

There are no third-party Composer or PHP library requirements. The module also
*suggests* **Layout Builder Modal** (`drupal/layout_builder_modal`), which adds a
modal for adding and configuring blocks — optional, but a nice companion.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_additions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_builder_additions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_additions -y
```

That's all — the module has no configuration. Its three improvements to the
Layout Builder experience apply immediately. To undo them, uninstall the module.
