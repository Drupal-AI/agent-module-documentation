# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core modules **Taxonomy** (`taxonomy`), **CKEditor 5** (`ckeditor5`), and
  **Filter** (`filter`) enabled. Drupal enables these automatically as
  dependencies.

There are no third-party Composer packages or external JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_taxonomy_glossary -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_taxonomy_glossary -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_taxonomy_glossary -y
```

Enabling the module creates the **Glossary** taxonomy vocabulary that holds your
terms.

## Verify it worked

Check that **Structure → Taxonomy** now lists a **Glossary** vocabulary. Then move
on to [Configuration](../configuration/index.md) to enable the filter, add the
toolbar button, grant permissions, and add your first term — the glossary links
will not appear until those steps are done.
