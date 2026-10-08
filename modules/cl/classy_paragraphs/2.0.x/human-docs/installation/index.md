# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Paragraphs** module (`drupal/paragraphs`, `~1.0`) — a hard dependency, installed
  automatically by Composer.

There are no third‑party libraries or special PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/classy_paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your host
> machine — `ddev composer require drupal/classy_paragraphs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en classy_paragraphs -y
```

This enables `paragraphs` as a dependency if it isn't already on. There are no submodules.

## After enabling

Nothing changes on your site until you create some styles and add a class‑picker field to a
Paragraph type. Continue to [Configuration](../configuration/index.md).
