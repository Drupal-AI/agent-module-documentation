# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) enabled — the only dependency for the base
  module, and Drupal enables it automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/single_image_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/single_image_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en single_image_formatter -y
```

The **Single image formatter** option becomes available immediately on any image
field, from its bundle's **Manage display** tab (see
[How to use it](../index.md#how-to-use-it)). There is no configuration step.

## Submodules — enable only what you need

The base module handles plain **image** fields. Two optional submodules extend
the same "first value only" behavior to other display types:

| Submodule | Machine name | What it adds | Also requires |
|-----------|--------------|--------------|---------------|
| **Single responsive image** | `single_image_formatter_responsive` | A **Single responsive image** formatter for image fields, based on core's responsive image formatter — art‑directed, breakpoint‑aware display of just the first image. | Core **Responsive Image** (`responsive_image`) |
| **Single media thumbnail** | `single_image_formatter_media` | A **Single media thumbnail** formatter for **media reference** (`entity_reference`) fields — shows the first referenced media item's thumbnail. | Core **Media** (`media`) |

Enable whichever you need, for example:

```bash
drush en single_image_formatter_responsive -y
```

Each submodule requires the base Single Image Formatter module, which is already
present once you have installed it above.
