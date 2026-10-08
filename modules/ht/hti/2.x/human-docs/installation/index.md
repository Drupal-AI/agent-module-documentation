# Installation

## Requirements

- **Drupal 8, 9, 10, 11, or 12** (`core_version_requirement:
  ^8 || ^9 || ^10 || ^11 || ^12`).
- Core's **Taxonomy** module (`taxonomy`) — the terms are imported into a
  taxonomy vocabulary.
- Core's **File** module (`file`) — used to handle the uploaded CSV.

Both dependencies ship with Drupal core and are enabled automatically. There are no
third‑party Composer or PHP library requirements.

## Install with Composer

Note that the **project (Composer) name is `hti`** while the **module machine name
is `hierarchical_taxonomy_importer`** — you require one and enable the other.

From the project root:

```bash
composer require drupal/hti -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hti -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**:

```bash
drush en hierarchical_taxonomy_importer -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Taxonomy Importer**. You
should see the import form, where you can select a vocabulary and upload a CSV. See
[Configuration](../configuration/index.md) for how to prepare and run an import
safely.
