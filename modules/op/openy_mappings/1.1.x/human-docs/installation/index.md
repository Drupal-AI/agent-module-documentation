# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No declared module dependencies of its own.
- Designed as part of the [Open Y / YMCA Website Services](https://www.drupal.org/project/openy)
  distribution; on a non-Open-Y site it is a generic mapping-entity building block.

## Install with Composer

From the project root:

```bash
composer require drupal/openy_mappings -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openy_mappings -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openy_mappings -y
```

On an Open Y site this module is normally enabled automatically as a dependency of
the syncers and components that use the Mapping entity type.

## Verify it worked

After enabling, the **Mapping** entity type is registered and available to the
modules (or custom code) that depend on it. There is no UI page to visit — success
is simply that the module enables cleanly and the components that require it can
create and read mapping entities.
