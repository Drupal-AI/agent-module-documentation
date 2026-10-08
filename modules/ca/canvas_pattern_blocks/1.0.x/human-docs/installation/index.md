# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- The **Canvas** module (`drupal/canvas`) — the Experience Builder page builder
  whose patterns this module exposes as blocks.
- This is a **1.0.0‑beta2** release.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_pattern_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (including Canvas if it is not already present).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/canvas_pattern_blocks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_pattern_blocks -y
```

Enabling it pulls in Canvas as a dependency if it is not already on. Afterwards,
review the permission the module declares at **People → Permissions**
(`/admin/people/permissions`), then place your Canvas patterns as blocks from the
Block layout or Layout Builder.
