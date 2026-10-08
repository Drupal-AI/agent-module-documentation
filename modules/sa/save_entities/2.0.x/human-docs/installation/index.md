# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No modules outside Drupal core are required.

There are no additional PHP or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/save_entities -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/save_entities -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en save_entities -y
```

## Set the permissions

Because this tool re‑saves content in bulk (creating revisions and running save
hooks), access to its forms is controlled by permissions. Go to **People →
Permissions** and grant the Save Entities permissions only to trusted
administrator roles.

## Verify it worked

Go to **`/admin/config/content/save-nodes`** (or `/admin/config/content/save-media`)
and confirm the bulk‑save form appears with your content types listed. See
[Configuration](../configuration/index.md) for how to use it.
