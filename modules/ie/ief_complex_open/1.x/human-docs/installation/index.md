# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- The **Inline Entity Form** module (`inline_entity_form`) — the required
  dependency this widget builds on.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ief_complex_open -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Inline Entity Form if it isn't present yet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ief_complex_open -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ief_complex_open -y
```

Drupal enables the required Inline Entity Form module automatically as a
dependency.

## Verify it worked

Go to a content type's **Manage form display**, switch an entity reference
field's widget to **Inline entity form - Complex (Open)**, and save. Then create
a node of that type — the "Add existing …" autocomplete should already be open and
ready for typing.
