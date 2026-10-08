# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The **Dynamic Entity Reference** module (`drupal/dynamic_entity_reference`,
  `^3 || ^4`) — Composer installs it for you. This is what lets one preview link
  reference entities of different types.

## Install with Composer

From the project root:

```bash
composer require drupal/preview_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including Dynamic Entity Reference) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/preview_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en preview_link -y
```

Enabling installs the `preview_link` content entity. Drupal will enable Dynamic
Entity Reference at the same time if it isn't already on.

## Next steps

Preview Link does **nothing** until you enable the entity types that should
support it and grant the create permission:

1. Open **Configuration → Content authoring → Preview Link**
   (`/admin/config/content/preview_link`) and enable your entity types/bundles and
   set the link lifetime.
2. Grant the **Generate preview links** permission to editorial roles.

See [Configuration](../configuration/index.md) for the details.
