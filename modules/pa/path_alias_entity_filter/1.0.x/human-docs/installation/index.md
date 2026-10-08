# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`) — this release targets Drupal 11
  only.
- Core's **Path** module (`path`) enabled — the only dependency. Drupal enables it
  automatically when you turn on Path Alias Entity Filter.

There are no third‑party Composer or PHP library requirements.

**Recommended:** [Pathauto](https://www.drupal.org/project/pathauto) — when it is
enabled with additional entity types opted in under **Enabled entity types**,
those types appear in the filter dropdown automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/path_alias_entity_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/path_alias_entity_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en path_alias_entity_filter -y
```

No configuration is required.

## Verify it worked

Go to **Configuration → Search and metadata → URL aliases**
(`/admin/config/search/path`). The alias filter form should now show a new
**Entity type** dropdown next to the search field. Select a type and click
**Filter** to confirm the list narrows to aliases pointing at that entity type.
