# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Drupal core only — no other modules, no Composer libraries, no PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_entity_id -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_entity_id -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_entity_id -y
```

## Configure before you can use it

Enabling the module is not enough on its own — the custom‑ID field only appears once
you've enabled it for a specific entity type on the settings form, and once a user
holds the module's permission. See [Configuration](../configuration/index.md).

## Verify it worked

After configuring, create a new entity of a type you enabled. As a user who holds the
custom‑ID permission, you should see a field for entering the entity's ID on the
create form. Enter an unused ID and save; entering an ID that already exists produces
an "Entity id already exists" message.
