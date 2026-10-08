# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No contributed module dependencies, third‑party Composer packages, or PHP
  extensions are required.

Entity Usage integrates with several optional modules if they are present — Entity
Embed, LinkIt, Block Field, Dynamic Entity Reference, and Layout Builder — but none
are required to install it.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_usage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_usage -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_usage -y
```

By default all content entity types (except files and users) are tracked as
sources and all tracking plugins are active, but **no Usage tabs are shown** until
you enable them — so head to [Configuration](../configuration/index.md) next.

## Rebuild usage data

Tracking only records relationships when a source entity is saved. To account for
content that already exists, rebuild the usage table after installing — either from
the batch-update form in the UI, or with the provided Drush command:

```bash
drush entity-usage:recreate
```

This erases and regenerates the whole usage table. Run it again whenever you change
which types or plugins are tracked, or after a large content import.

## Verify it worked

Visit **Configuration → Content authoring → Entity Usage Settings**
(`/admin/config/entity-usage/settings`). If the settings form loads, the module is
active. Enable a Usage tab for a content type (see
[Configuration](../configuration/index.md)), then open a node that references other
content and check that the **Usage** tab appears and lists the relationships.
