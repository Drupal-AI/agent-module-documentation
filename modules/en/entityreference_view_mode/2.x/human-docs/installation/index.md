# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) — enabled on virtually every site, and Drupal
  enables it automatically as a dependency.
- No third‑party Composer or PHP libraries are required.

> **Version note:** the 2.x branch references across all entity types. There is
> **no upgrade path** from the older 8.x‑1.x branch, so choose your branch before
> building fields you intend to keep.

## Install with Composer

From the project root:

```bash
composer require drupal/entityreference_view_mode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entityreference_view_mode -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entityreference_view_mode -y
```

## Verify it worked

On any bundle, go to **Manage fields → Add field**. The **Entity Reference View
Mode** field type should appear in the list. Add one, then check that its widget
(on Manage form display) and formatter (on Manage display) are available. See
[How to use it](../index.md#how-to-use-it) for the full walkthrough.
