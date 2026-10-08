# Installation

## Requirements

Facets Pretty Paths needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Facets** module (`drupal/facets`, `^2 || ^3`) — the faceted-search system
  this plugs into.
- The **Pathauto** module (`drupal/pathauto`, `^1`) — supplies the alias cleaner
  that several coders use to build tidy slugs.

Both are pulled in by Composer. A working faceted search (typically built on
**Search API**) needs to exist first — pretty paths changes how an existing
facet source builds its URLs; it does not create the search for you.

**Suggested (optional):**

- **Better Exposed Filters** — for AJAX support when facets are rendered as Views
  exposed filters.
- **Search API** — the usual search backend facets are built on.

## Install with Composer

From the project root:

```bash
composer require drupal/facets_pretty_paths -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Facets and
Pathauto and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/facets_pretty_paths -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets_pretty_paths -y
```

Drupal enables the Facets and Pathauto dependencies for you if they are not
already on.

## Next steps

There is no dedicated settings page. To start using pretty paths, switch a facet
source's URL processor and choose coders — see
[Configuration](../configuration/index.md).
