# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Search API** module (`search_api`) — the only dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_term_with_depth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_term_with_depth -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_term_with_depth -y
```

Then clear caches so the new depth option appears in the Views UI:

```bash
drush cr
```

## Verify it worked

Edit a Search API-based View and add a filter or argument for a taxonomy term
field. A **depth** select list should now appear alongside it, with a description
explaining how the hierarchy match works.
