# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core modules **Taxonomy**, **Field UI**, and **User** — these are dependencies
  and Drupal will enable them as needed.
- No third-party Composer or PHP library requirements are declared.

## Install with Composer

From the project root:

```bash
composer require drupal/access_by_taxonomy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/access_by_taxonomy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en access_by_taxonomy -y
```

## Rebuild node access

Because this module uses Drupal's node-grants system, you must rebuild the grants
table after enabling it (and again after any change to your access configuration):

```bash
drush php:eval 'node_access_rebuild();'
```

Then configure the **Allowed users** / **Allowed roles** fields on your access
taxonomy and verify access as described in the parent [guide](../index.md). Note
that node access is **additive** across modules — if you run other node-access
modules, the effective access is the union of them all.
