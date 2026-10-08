# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies and no third‑party PHP or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/component_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/component_connector -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en component_connector -y
```

## Verify it worked

The module is a developer framework, so there is little user-visible to check.
Visit **Configuration → System → Components settings**
(`/admin/config/system/component_connector_settings`) and confirm the **Theme**
select appears — set it to the theme that holds your components. Then add a
component definition YAML file in that theme, clear the cache (`drush cr`), and
confirm your component's theme hook and libraries are picked up when you render
it.
