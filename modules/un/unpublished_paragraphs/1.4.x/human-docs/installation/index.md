# Installation

## Requirements

Unpublished Paragraphs needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Paragraphs** module (`drupal/paragraphs`) enabled — this is the only
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/unpublished_paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (If you don't already have Paragraphs, add it too:
`composer require drupal/paragraphs drupal/unpublished_paragraphs -W`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/unpublished_paragraphs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en unpublished_paragraphs -y
```

That's all. There's no configuration and no new permission — the marking and toggle
button appear automatically on front‑end pages that contain unpublished paragraphs,
for users who are allowed to view them. See
[How to use it](../index.md#how-to-use-it).
