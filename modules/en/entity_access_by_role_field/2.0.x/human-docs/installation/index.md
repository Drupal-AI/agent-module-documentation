# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- No other modules, PHP libraries, or Composer dependencies — it builds entirely on
  core's Field and entity‑access systems.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_access_by_role_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_access_by_role_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_access_by_role_field -y
```

## Verify it worked

Go to any content type's **Manage fields** screen (for example
**Structure → Content types → Article → Manage fields**) and click **Add field**.
In the field‑type list you should now see **Entity Access by Role** under the
*Access* category. Then continue to [Configuration](../configuration/index.md) to add
and configure the field.
