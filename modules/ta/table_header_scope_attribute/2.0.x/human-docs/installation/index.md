# Installation

## Requirements

Table Header Scope Attribute is small and self‑contained. It needs:

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Filter** module (`filter`) enabled — this is the only dependency, and
  Drupal enables it automatically. (Filter is on by default on virtually every site.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/table_header_scope_attribute -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/table_header_scope_attribute -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en table_header_scope_attribute -y
```

Enabling the module does nothing on its own — it just makes the two filters available.
To activate them, turn them on for a text format as described in
[How to use it](../index.md#how-to-use-it).
