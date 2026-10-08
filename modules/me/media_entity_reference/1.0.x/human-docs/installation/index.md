# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **Media** (`media`) and **Media Library** (`media_library`)
  modules, which Drupal enables automatically as dependencies.

There are no contributed‑module dependencies and no third‑party PHP libraries to
install.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_reference -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_reference -y
```

Core's Media and Media Library modules are enabled automatically if they are not
already on.

## Verify it worked

Go to **Structure → Media types → Add media type**
(`/admin/structure/media/add`) and confirm the reference media source provided by
this module appears in the **Media source** dropdown. Full step‑by‑step setup is
in the [main guide](../index.md).
