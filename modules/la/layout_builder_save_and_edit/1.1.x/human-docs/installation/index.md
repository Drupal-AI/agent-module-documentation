# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal enables it automatically when you turn this module on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_save_and_edit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_builder_save_and_edit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_save_and_edit -y
```

That is all it takes. The **Save and edit layout** button now appears on Layout
Builder forms site‑wide. There is no configuration, no permission to grant, and no
submodules — the enhancement applies immediately everywhere Layout Builder is
used.
