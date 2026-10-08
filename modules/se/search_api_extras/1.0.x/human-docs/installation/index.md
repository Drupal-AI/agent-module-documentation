# Installation

## Requirements

Search API Extras needs:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- **Search API** (`search_api`).
- Core's **Views** module if you want to use the conditional-relevance sort
  handler (Views ships with Drupal core and is enabled on most sites).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name (`drupal/search_api_extras`)
matches the module's machine name (`search_api_extras`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_extras -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_extras -y
```

Enabling the module makes the parser override and the conditional-relevance sort
handler available. Neither changes anything until you choose to use it — see
[How to use it](../index.md#how-to-use-it) in the main guide.

## Verify it worked

Edit a Search API-backed View and confirm that a **conditional relevance** sort
criterion is available to add, and/or check that the module's multiple-terms
parser can be selected in your index or view query settings.
