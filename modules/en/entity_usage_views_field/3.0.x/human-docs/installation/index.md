<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: >=10`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The **Entity Usage** module (`drupal/entity_usage`) — this is a hard dependency and
  supplies all the tracking data the field displays. Composer pulls it in
  automatically, and Drupal enables it when you enable this module.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_usage_views_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including Entity Usage) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_usage_views_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_usage_views_field -y
```

This also enables Entity Usage if it was not already on. There are no submodules and
no configuration form.

## After enabling

For the counts to be meaningful, Entity Usage needs to have tracked some references.
If you have just installed Entity Usage, review its settings at **Configuration →
Content authoring → Entity Usage settings** and let it record usage as content is
created and referenced. Then add the **Entity usage count** field to a view — see
[How to use it](../index.md#how-to-use-it) on the overview page.
