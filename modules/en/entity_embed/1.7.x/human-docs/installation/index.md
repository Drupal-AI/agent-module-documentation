# Installation

## Requirements

Entity Embed needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The contrib **Embed** module (`drupal/embed`, `^1.10`) — this is a Composer
  requirement and is pulled in automatically when you install Entity Embed with
  Composer.
- Core's **Editor**, **Filter**, and **System** modules — Drupal enables these as
  dependencies when you turn on Entity Embed.
- A configured text editor (CKEditor 5, or CKEditor 4 on older setups) on the text
  format you want to embed into.

Optionally, install **Entity Browser** (`drupal/entity_browser`) if you want editors
to pick existing entities through a browser step in the embed dialog.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_embed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required Embed
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_embed -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_embed -y
```

This also enables the Embed module and the core Editor/Filter dependencies if they
are not already on.

Entity Embed has no submodules. Once it is enabled, continue to
[Configuration](../configuration/index.md) to create an embed button and turn on the
filter — the button and filter are what make embedding actually work.
