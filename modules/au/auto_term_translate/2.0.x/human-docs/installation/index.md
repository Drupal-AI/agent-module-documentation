# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Content Translation** module (`content_translation`).
- The **Auto Node Translate** module (`auto_node_translate`) — this module
  extends it and reuses its configured translation provider. Install a provider
  for Auto Node Translate too (for example Auto Node Translate Google or Auto
  Node Translate Libre) so there is something to translate with.

Composer will pull in `auto_node_translate` as a dependency; Content Translation
ships with core and Drupal enables it automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_term_translate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Auto Node Translate.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_term_translate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_term_translate -y
```

This also enables `content_translation` and `auto_node_translate` if they are not
already on.

## After enabling

- Configure Auto Node Translate's translation provider (its settings live at
  route `auto_node_translate.settings`) — Auto Taxonomy Term Translation has no
  settings page of its own and relies on that provider.
- Grant the **`use bulk auto translate`** permission to trusted editors at
  **People → Permissions**.
- Then use the per-term translate tab or the per-vocabulary bulk form as
  described on the [overview page](../index.md).
