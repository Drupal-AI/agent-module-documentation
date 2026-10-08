# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- Core's entity‑reference support (standard on any Drupal site). For composite
  *revisions* behavior you will typically be using
  `entity_reference_revisions` fields (as provided by, e.g., the Paragraphs
  ecosystem).

There are no third‑party Composer or PHP library requirements. Note the module is
licensed **EUPL‑1.2**.

## Install with Composer

From the project root:

```bash
composer require drupal/composite_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/composite_reference -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en composite_reference -y
```

There are no submodules. Once enabled, a **Composite reference** section appears on
the settings form of every entity‑reference and entity‑reference‑revisions field —
see [How to use it](../index.md#how-to-use-it).
