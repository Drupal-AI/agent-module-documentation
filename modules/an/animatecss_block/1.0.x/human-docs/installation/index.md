# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — enabled by default on most sites.
- The **AnimateCSS UI** module (`animatecss_ui`, the AnimateCSS base project) — this
  module extends it and reuses its Animate.css library.

Composer pulls in the AnimateCSS project; enable the UI module alongside this one.

## Install with Composer

From the project root:

```bash
composer require drupal/animatecss_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/animatecss_block -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en animatecss_block -y
```

This also enables the Block and AnimateCSS UI modules if they are not already on. See
[How to use it](../index.md#how-to-use-it) in the overview for setting defaults and
animating individual blocks.
