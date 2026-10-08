# Installation

## Requirements

Nodetype Access is lightweight and has no third‑party dependencies:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- Core's node system (any site with content types).

There are no Composer or PHP library requirements beyond Drupal itself.

## Install with Composer

From the project root:

```bash
composer require drupal/nodetype_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nodetype_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nodetype_access -y
```

Enabling the module does not change anything on its own — no content is hidden
until you grant (or withhold) the new per‑type view permissions. Head to
[Configuration](../configuration/index.md) next.

## Verify it worked

Go to **People → Permissions** (`/admin/people/permissions`) and search the page
for "view". You should now see a **view *[type]* nodes** permission for each of
your content types. That confirms the module is active and ready to configure.
