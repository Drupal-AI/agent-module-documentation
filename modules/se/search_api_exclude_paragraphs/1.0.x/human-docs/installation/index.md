# Installation

## Requirements

Search API Exclude Paragraphs needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Search API** (`search_api`).
- **Paragraphs** (`paragraphs`), since the whole point is to exclude Paragraph
  bundles.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_exclude_paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name
(`drupal/search_api_exclude_paragraphs`) matches the module's machine name
(`search_api_exclude_paragraphs`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_exclude_paragraphs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_exclude_paragraphs -y
```

Enabling the module makes the **Exclude Paragraphs** processor available. It does
nothing on its own until you turn the processor on for an index and select which
Paragraph types to exclude — see
[How to use it](../index.md#how-to-use-it) in the main guide.

## Verify it worked

Edit a Search API index, open the **Processors** tab, and confirm that **Exclude
Paragraphs** appears in the list of available processors.
