# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No third-party Composer or PHP libraries, and no other contrib modules — Preview builds
  entirely on core's entity and view-mode systems.

## Install with Composer

Note the naming quirk: the **project (and Composer package) is `all_entity_preview`**, but
the **module machine name is `preview`**. From the project root:

```bash
composer require drupal/all_entity_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/all_entity_preview -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `preview` (not `all_entity_preview`):

```bash
drush en preview -y
```

Enabling the module does not switch preview on for any content yet — nothing changes until
you enable it per entity type and bundle. Head to
[Configuration](../configuration/index.md) to choose which bundles get a Preview button.
