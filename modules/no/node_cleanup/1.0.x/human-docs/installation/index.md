# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Node** module (`node`) — the only dependency.

There are no contributed module dependencies, external libraries, or JavaScript
build tools. No extra content types, fields, or text formats are needed.

**Recommended (optional):**

- **Automated Cron** (core) or **Ultimate Cron** — needed if you enable scheduled
  auto‑purge, since permanent cleanup happens during cron.
- **Admin Toolbar** — for quicker navigation between the module's admin pages.

## Install with Composer

From the project root:

```bash
composer require drupal/node_cleanup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_cleanup -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_cleanup -y
```

## Verify it worked

Grant the core **Administer content** permission to the appropriate roles at
**People → Permissions**, then visit **Content → Node Cleanup**
(`/admin/content/node-manager`). You should see the four tabs — **List**, **Trash**,
**Duplicate Content**, and **Settings**. See the [overview](../index.md) for how to
use each one and how to enable scheduled auto‑purge.
