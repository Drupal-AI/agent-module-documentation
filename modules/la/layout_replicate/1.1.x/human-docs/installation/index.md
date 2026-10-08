# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`), enabled on the content type
  with per‑node overrides allowed.
- Core's **Node** module (`node`) and **Block content** module (`block_content`).
- For multi‑language workflows only: core's **Language** and **Content
  translation** modules.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_replicate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_replicate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_replicate -y
```

## Verify it worked

Open a Layout Builder‑enabled node as a user with the **Administer nodes**
permission and confirm a **Clone Layout** tab appears. You can also check the
activity report at **Reports → Layout Replicate**
(`/admin/reports/layout-replicate`). See "How to use it" in the
[overview](../index.md) for the full walkthrough.
