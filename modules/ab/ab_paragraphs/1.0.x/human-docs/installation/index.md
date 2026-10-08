# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The module works with Drupal's Paragraphs workflow, so you will want the
  Paragraphs module available to place the A/B test paragraph type on a content
  type.

There are no third-party Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/ab_paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ab_paragraphs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ab_paragraphs -y
```

Once enabled, the A/B test paragraph type is available to add to your
paragraph-reference fields. There is no required configuration form.
