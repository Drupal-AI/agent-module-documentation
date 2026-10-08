# Installation

## Requirements

- **Drupal 10.2 or newer, or Drupal 11**
  (`core_version_requirement: ^10.2 || ^11`).
- Core's **Taxonomy** module (you will already have this if you are importing
  terms).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/lupus_taxonomy_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lupus_taxonomy_import -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lupus_taxonomy_import -y
```

## Set the permission

The module adds a dedicated **`import taxonomy csv`** permission. Grant it at
**People → Permissions** (`/admin/people/permissions`) to the roles that should
be allowed to import terms. Users with the core **Administer taxonomy**
permission can also use the importer. Granting the dedicated permission on its own
is the recommended approach when you want a data‑entry role to load vocabularies
without gaining the broader ability to restructure taxonomy.

## Verify it worked

Log in as a user with the import permission and visit
`/admin/config/content/taxonomy/csv_import`. You should see the import form along
with links to the example CSV files (flat and hierarchical). Downloading one of
the examples is the quickest confirmation that the module is installed and
working.
