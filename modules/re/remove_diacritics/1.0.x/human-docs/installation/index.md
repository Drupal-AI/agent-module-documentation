# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No modules outside Drupal core, and no third‑party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/remove_diacritics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/remove_diacritics -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en remove_diacritics -y
```

## After installing: reindex search

If any search index depends on diacritic removal, rebuild it now so existing
content is reprocessed with the module's wider character coverage. You can trigger
a reindex from your search setup (for example the Search API index's operations, or
core Search's re-index option under **Configuration → Search and metadata**).

## Verify it worked

The module exposes diacritic removal for slug generation, search normalization, and
other transliteration needs — there is no admin screen to view. Confirm success in
context: for example, generate a slug or run a search using accented input and
check that accented characters are reduced to their base letters as expected.
