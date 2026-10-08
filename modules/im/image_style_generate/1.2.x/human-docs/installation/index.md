# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — provides the Image Style entity and Image
  Effect plugins.
- Core's **Migrate** module (`migrate`) — this module's source plugin runs on top
  of it.

Both core dependencies are enabled automatically when you enable this module.

Recommended companions (not required):

- [Migrate Plus](https://www.drupal.org/project/migrate_plus) — enhances core
  Migrate functionality.
- [Migrate Tools](https://www.drupal.org/project/migrate_tools) — adds a UI and
  Drush commands for running your migrations.

## Install with Composer

From the project root:

```bash
composer require drupal/image_style_generate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To add the recommended tooling at the same time:

```bash
composer require drupal/image_style_generate drupal/migrate_plus drupal/migrate_tools -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_style_generate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_style_generate -y
```

## Submodules

The module ships two example submodules that demonstrate working migration
definitions. Enable one while you learn the format, then copy its YAML into your
own module:

| Submodule | Machine name | What it shows |
|-----------|--------------|---------------|
| **Example** | `image_style_generate_example` | A basic definition — a simple set of generated styles. |
| **Advanced example** | `image_style_generate_example_advanced` | A fuller definition using style groups, base sizes, and size scales. |

```bash
drush en image_style_generate_example -y
```

## Verify it worked

After enabling an example submodule (or running your own migration with Migrate
Tools), open **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`) and confirm the generated styles appear in
the list. See the [manual setup guide](../index.md) for how to write and run your
own definition.
