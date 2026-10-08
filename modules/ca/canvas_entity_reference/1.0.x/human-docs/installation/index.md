# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **Drupal Canvas** module (`canvas`) — this is the module's only dependency,
  and Canvas must be installed and enabled for the entity-reference support to have
  anything to plug into.

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_entity_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you do not already have Drupal Canvas installed,
require it as well (`composer require drupal/canvas -W`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/canvas_entity_reference -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_entity_reference -y
```

## Verify it worked

Once enabled, a developer can add `x-entity-type: taxonomy_term` (or `node`,
`user`, `media`) to a component prop in its YAML, and that prop will appear as an
entity-reference autocomplete field in the Canvas editor. The module also ships
seven example components (media reference, node reference by title or by ID, user
reference, multi-value taxonomy, and a bundle-filter example) — dropping one of
those into a Canvas page is the quickest way to confirm everything is wired up.
For the optional global defaults, continue to [Configuration](../configuration/index.md).
