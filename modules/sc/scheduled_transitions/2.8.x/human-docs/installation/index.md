<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- **PHP 8.3 or newer**.
- Core's **Content Moderation** module (`content_moderation`) — Scheduled
  Transitions only works on content types that use a moderation workflow.
- The **Dynamic Entity Reference** module (`drupal/dynamic_entity_reference`
  `^3.0 || ^4.0`) — a Composer dependency pulled in automatically.
- *Optional:* the **Token** module, which adds a token browser to the "Add
  scheduled transition" form.

## Install with Composer

From the project root:

```bash
composer require drupal/scheduled_transitions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in Dynamic Entity Reference.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/scheduled_transitions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scheduled_transitions -y
```

Drupal enables Content Moderation and Dynamic Entity Reference at the same time if
they are not already on. After enabling, you must enable the specific content
types you want to schedule and grant permissions — see
[Configuration](../configuration/index.md).

This module has no submodules of its own.
