# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- **DOI Publications** (`doi_search`) — this is a hard dependency. It is what
  actually resolves a DOI to publication metadata. When you install DOI Field
  with Composer, `doi_search` is pulled in and enabled automatically.
- No third‑party Composer packages beyond the above and no separate PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/doi_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — and Composer automatically brings in DOI Publications
(`doi_search`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/doi_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en doi_field -y
```

Drupal enables the required `doi_search` module at the same time, since DOI Field
depends on it.

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field**.
The **DOI Field** field type should appear in the list of available field types.
Add one, then confirm you can enter a DOI on that content type and choose its
display options under **Manage display**.
