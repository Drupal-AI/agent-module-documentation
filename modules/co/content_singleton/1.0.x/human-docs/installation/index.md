# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **PHP 8.3 or newer** — this is a hard requirement; confirm your host/container
  runs it before installing.
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP
  library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_singleton -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_singleton -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_singleton -y
```

## Verify it worked

Go to **Structure → Content Singleton Types**
(`/admin/structure/content-singleton`). If the page loads and offers **Add Content
Singleton Type**, the module is installed. Create a type, add a field or two, then
create its single instance at **Content → Content Singletons**
(`/admin/content-singleton`) and visit its configured path. See the main guide's
[How to use it](../index.md#how-to-use-it) section for the full walkthrough.
