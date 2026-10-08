# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Field** (`field`) and **Taxonomy** (`taxonomy`) modules — Drupal
  enables these automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/hierarchical_select_ajax -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hierarchical_select_ajax -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hierarchical_select_ajax -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with a taxonomy term field)* →
Manage form display**. Open the **Widget** drop‑down for that field — you should
now see **Hierarchical select ajax** as an option. Selecting it and saving turns
the field into a cascading, AJAX‑loaded set of selects. See "How to use it" in the
[overview](../index.md) for the per‑field settings.
