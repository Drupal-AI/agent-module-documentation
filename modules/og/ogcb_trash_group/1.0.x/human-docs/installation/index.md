# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- The **Trash** module (`trash`).
- The **Group** module (`group`).

Both modules are required. There are no third‑party Composer libraries or special
PHP extensions to install.

## Install with Composer

From the project root:

```bash
composer require drupal/ogcb_trash_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will pull in Trash and Group if they aren't
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ogcb_trash_group -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ogcb_trash_group -y
```

This also enables Trash and Group if they aren't already on. The cascade hooks
activate as soon as the module is enabled — there is no further configuration for
the module itself.

## Turn on Trash for the right bundles

For the cascade to work, enable Trash for the entity type bundles and their
corresponding group relationship bundles at **Configuration → Content → Trash**
(`/admin/config/content/trash`).

## Verify it worked

Trash a group that has related content and confirm its relationships and related
entities move to the recycle bin with it; restore the group and confirm they come
back together. You should also see the trash‑aware wording on group relationship
delete confirmation forms. See the [guide overview](../index.md) for details.
