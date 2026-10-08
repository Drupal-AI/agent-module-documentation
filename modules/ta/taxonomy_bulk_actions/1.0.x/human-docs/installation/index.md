# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** module enabled — the module enhances the taxonomy term
  overview page, so you need taxonomy in use.

There are no third‑party Composer or PHP library requirements, and no other
module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_bulk_actions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/taxonomy_bulk_actions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_bulk_actions -y
```

That's all it takes. There is no configuration and there are no submodules. Open
any vocabulary's term overview under **Structure → Taxonomy** and the checkboxes
and bulk‑action selector appear automatically. Make sure the users who need it
hold the appropriate core taxonomy permissions (*Administer taxonomy*, and
*Delete terms* for a vocabulary if they should be able to delete).
