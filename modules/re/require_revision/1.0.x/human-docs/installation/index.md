# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Node**, **Taxonomy**, and **Block content** modules — Drupal enables
  any that are missing automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/require_revision -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/require_revision -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en require_revision -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Content authoring →
Require Revision** (`/admin/config/content/require-revision`). You should see the
three collapsible sections — Block Types, Content Types, and Taxonomy
Vocabularies. Tick a bundle, save, then edit an existing item of that type: Drupal
should now create a new revision on save. See the "How to use it" section of the
[overview](../index.md) for the full walkthrough.
