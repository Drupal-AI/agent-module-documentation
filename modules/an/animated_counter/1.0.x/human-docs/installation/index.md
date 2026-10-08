# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`) — enabled by default on most sites.
- The **Block Animate** module (`block_animate`) — provides the scroll-triggered
  animation this module builds on.

Composer pulls in Block Animate; enable it alongside this module.

## Install with Composer

From the project root:

```bash
composer require drupal/animated_counter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/animated_counter -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en animated_counter -y
```

This also enables the Block and Block Animate modules if they are not already on. See
[How to use it](../index.md#how-to-use-it) in the overview for placing and configuring the
counter block.
