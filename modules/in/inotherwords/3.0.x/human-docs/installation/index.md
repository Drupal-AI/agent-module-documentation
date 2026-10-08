# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
  The 3.x line you are installing here supports Drupal 10 and 11 (earlier 1.x did
  not support Drupal 10).
- No contributed modules and no external libraries. It works with core field
  types — text lists, entity‑reference labels, and taxonomy‑term fields.

## Install with Composer

From the project root:

```bash
composer require drupal/inotherwords -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inotherwords -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inotherwords -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with a multi‑value list or
reference field)* → Manage display**. Open the format dropdown for that field —
you should now see the **In other words: List** formatter and, for taxonomy‑term
fields, **In other words: Sequential terms**. Choose one, adjust its settings, and
view a piece of content to confirm the list renders as natural‑language text. See
[How to use it](../index.md#how-to-use-it) for the details.
