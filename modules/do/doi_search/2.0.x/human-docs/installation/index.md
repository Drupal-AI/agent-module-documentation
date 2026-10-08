# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- No contributed module dependencies and no separate PHP library requirements.
- **Outbound network access** — the module queries an external DOI metadata
  service (Crossref) to resolve DOIs, so the server must be able to reach it.

## Install with Composer

From the project root:

```bash
composer require drupal/doi_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/doi_search -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en doi_search -y
```

## Set the permissions

DOI Publications provides its own permissions. Go to **People → Permissions**,
filtered to this module at `/admin/people/permissions/module/doi_search`, and
grant the appropriate permission to the roles that should be able to search for
and resolve publications.

## Verify it worked

Visit `/doi-search` as a user who has the permission and run a search — the page
should return publication metadata for a valid DOI. If lookups fail, confirm the
server has outbound access to the external DOI service.
