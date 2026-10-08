# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- To get the most out of it you'll want fields that use **entity reference** or
  **entity reference revisions** (the latter is provided by the contributed
  Entity Reference Revisions module, commonly used with Paragraphs). The
  **Field linker** formatter works on any field type.

There are no third-party Composer packages or PHP libraries to install, and the
module has no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/field_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_formatter -y
```

That's all it takes. There is no configuration form — the three formatters
become available in the **Format** dropdown on your bundles' **Manage display**
pages. See the [overview](../index.md) for how to use each one.
