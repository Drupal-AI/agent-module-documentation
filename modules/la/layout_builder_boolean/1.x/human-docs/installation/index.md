# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal enables it automatically as a dependency when you turn on
  Layout Builder Boolean.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_boolean -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_boolean -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_boolean -y
```

## Verify it worked

Open a Layout Builder‑enabled display (for example **Structure → Content types →
Article → Manage display → Layout**), add a section, and open the layout chooser.
You should see new **Boolean** variants of your layouts (such as "One column
(Boolean)"). If those variants appear, the module is working — configure the switch
field on a boolean section as described in the [manual setup guide](../index.md).
