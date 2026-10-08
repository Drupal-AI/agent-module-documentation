# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- The **Organic Groups** module (`og`) — this is the only dependency, and it is
  required. `og_access` extends Organic Groups and does nothing without it.

There are no third‑party Composer libraries or special PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/og_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/og_access -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en og_access -y
```

Enabling `og_access` also ensures Organic Groups (`og`) is enabled, since it is a
hard dependency.

## Rebuild node access permissions

This module hooks into Drupal's node access grant system, so after enabling it you
should rebuild the grants for existing content:

```bash
drush php:eval 'node_access_rebuild();'
```

Alternatively, visit **Reports → Status report** and follow the "rebuild
permissions" prompt if Drupal shows one.

## Verify it worked

Open a group and edit it — you should see a **Group visibility** (Public/Private)
control. Edit a piece of group content and you should see a matching **Group
content visibility** control. Mark something Private, then view the site as a
non‑member and confirm the private item is not visible in listings or by direct
URL. Full step‑by‑step usage is in the [guide overview](../index.md).
