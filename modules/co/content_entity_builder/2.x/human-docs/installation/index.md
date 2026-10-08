# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- No required contrib dependencies and no third‑party PHP or JavaScript
  libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/content_entity_builder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_entity_builder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_entity_builder -y
```

Because this module is a build‑time developer tool that can create entity types
and generate code, enable it on development and staging where you design your
entities. Restrict its use to trusted developers.

## Verify it worked

Go to **Structure → Content types** (`/admin/structure/content-types`). With the
module enabled you should be able to add a new custom content entity type from
here, and an **Export** tab should be available. See
[Configuration](../configuration/index.md) for the full build workflow.

> **Tip:** If a change doesn't seem to take effect, clear the cache
> (`drush cr`) — the maintainers specifically recommend this when working with
> this module.
