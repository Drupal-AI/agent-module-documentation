# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`). The friction it fixes appears
  in Drupal 11.3+, where the term‑overview form began extending `EntityForm`.
- **[Config Read-only](https://www.drupal.org/project/config_readonly)** (`config_readonly`)
  — the module whose read‑only mode this one makes an exception to. It is a hard dependency,
  and this module only makes sense on a site running Config Read-only.
- Core's **Taxonomy** (`taxonomy`) module — enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements. Note this is an **alpha**
release (1.0.0‑alpha1).

## Install with Composer

From the project root:

```bash
composer require drupal/config_readonly_taxonomy_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the dependencies and update
any shared dependencies as needed. Config Read-only itself is a separate project — require it
too if it is not already present (`composer require drupal/config_readonly -W`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_readonly_taxonomy_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_readonly_taxonomy_ui -y
```

Drupal will enable Config Read-only and Taxonomy at the same time if they are not already on.

## Verify it worked

With Config Read-only active (its read‑only mode turned on), go to **Structure → Taxonomy**,
open a vocabulary, and confirm you can reorder its terms on the overview page — while editing
the vocabulary settings and deleting it stay blocked. If term reordering works but those other
operations remain locked, the module is doing its job. There is no settings form to visit.
