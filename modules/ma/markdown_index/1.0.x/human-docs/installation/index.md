# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/markdown_index -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/markdown_index -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en markdown_index -y
```

## Verify it worked

After enabling, open **Configuration → System → Markdown Index Settings**
(`/admin/config/system/markdown-index`) to choose which folders to scan, then look
for **Markdown Index Report** under **Reports** (`/admin/reports/markdown-index`).
See [Configuration](../configuration/index.md) for the full walkthrough.
