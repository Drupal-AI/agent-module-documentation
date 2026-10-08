# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- No dependencies of its own — the module bridges whatever node-access modules are
  already installed (for example Content Access, Domain Access, Workflow, Organic
  Groups, or Taxonomy Access Control).
- No third-party Composer or PHP library requirements are declared.

## Install with Composer

From the project root:

```bash
composer require drupal/acb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acb -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acb -y
```

## After enabling — rebuild and test

Because this module changes how node-access grants combine, rebuild the grants
table and then verify access carefully:

```bash
drush php:eval 'node_access_rebuild();'
```

Then check your role-by-content-state grid, including the anonymous row, before
and after. See the parent [guide](../index.md) for why this verification is the
real work of installing an access-control module.
