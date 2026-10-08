# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- The **Paragraphs** module (`drupal/paragraphs`, `~1.0`) — Composer pulls it in,
  and Drupal enables it as a dependency.

There are no third-party PHP library requirements. The optional JavaScript table
libraries (DataTables, Bootstrap Table, Google Charts) are integrated by the
module's table modes; consult the project page if you need to supply those
assets locally.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_table -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update the shared
dependencies (including Paragraphs) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/paragraphs_table -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_table -y
```

This also enables Paragraphs if it is not already on. Now configure a Paragraphs
reference field's display and/or form display to use the table — see
[Configuration](../configuration/index.md).
