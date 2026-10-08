# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) enabled — this is the only dependency,
  and Drupal enables it automatically if needed.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_path_breadcrumb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/taxonomy_path_breadcrumb -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_path_breadcrumb -y
```

Enabling the module changes nothing on its own — every vocabulary keeps its
current breadcrumb behavior until you opt one in. See
[Configuration](../configuration/index.md) to switch a vocabulary to path‑based
breadcrumbs.

## Verify it worked

Edit any vocabulary at **Structure → Taxonomy → *(vocabulary)* → Edit**. If you
see a new **Breadcrumb builder settings** section with a *Select Breadcrumb
Service* dropdown, the module is installed correctly.
