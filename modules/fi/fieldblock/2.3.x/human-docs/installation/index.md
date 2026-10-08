# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) enabled — the only dependency, and Drupal
  enables it automatically when you turn on Field as Block.
- No third-party Composer libraries or PHP extensions.

## Install with Composer

From the project root:

```bash
composer require drupal/fieldblock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fieldblock -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fieldblock -y
```

On enable, the **Content field**, **User field**, and **Taxonomy term field**
block types become available in Block layout right away. Nothing is rendered until
you place one and choose a field — see [Configuration](../configuration/index.md).

## Grant the permission

The module adds one permission, **Administer fieldblock**
(`administer fieldblock`), which controls access to the settings form that chooses
which entity types expose field blocks. Grant it to administrators at **People →
Permissions** (`/admin/people/permissions`). (Placing the blocks themselves uses
core's ordinary *Administer blocks* permission.)

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`), click **Place
block** on any region, and look for **Content field**, **User field**, and
**Taxonomy term field** in the list. If they appear, the module is installed
correctly. Continue with [Configuration](../configuration/index.md) to place one.
