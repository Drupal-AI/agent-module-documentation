# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Several modules, all declared as dependencies:
  - core's **CKEditor 5** (`ckeditor5`) — enabled automatically.
  - the **Embed** module (`embed`).
  - the **Entity Embed** module (`entity_embed`).
  - the **Paragraphs** module (`paragraphs`).

Embed, Entity Embed, and Paragraphs are contrib modules; Composer pulls them in for
you with the command below. There is no PHP version requirement and no third-party
Composer libraries beyond those modules.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_entity_embed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Embed, Entity
Embed, and Paragraphs and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_entity_embed -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_entity_embed -y
```

This also enables CKEditor 5, Embed, Entity Embed, and Paragraphs if they are not
already on. Enabling the module ships a ready-made **Paragraphs** embed button and
an **Embed** view mode for paragraphs, but nothing is active until you switch it on
for a text format — see [Configuration](../configuration/index.md).

There are no submodules.
