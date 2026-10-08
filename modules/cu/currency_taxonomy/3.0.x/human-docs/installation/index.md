# Installation

## Requirements

- **Drupal 8.8 or newer, through 11** (`core_version_requirement:
  ^8.8||^9||^10||^11`).
- Core's **Taxonomy** module (`taxonomy`) — the only dependency, and Drupal
  enables it automatically.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/currency_taxonomy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/currency_taxonomy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en currency_taxonomy -y
```

Core's Taxonomy module is enabled at the same time as a dependency. Enabling the
module creates the currency vocabulary.

## Populate the vocabulary

The module ships **Drush commands** to populate and manage the vocabulary with the
currency terms. Run `drush list` to find the module's commands, then run the
populate command to fill the vocabulary with ISO currency codes and their
countries.

## Verify it worked

Go to **Structure → Taxonomy** (`/admin/structure/taxonomy`) and confirm the
currency vocabulary is present. After populating it, its term list should show
entries in the *Currency Name (ISO code)* format.
