# Installation

## Requirements

- **Drupal 10.2 or newer, or Drupal 11** (`core_version_requirement: ^10.2 || ^11`).
- The **[Auto Node Translate](https://www.drupal.org/project/auto_node_translate)**
  module (`drupal/auto_node_translate` `^3.0`) — this module is a provider plugin
  for it and does nothing on its own.
- The **`deeplcom/deepl-php`** library (`^1.10`) — DeepL's official PHP client,
  installed by Composer.
- A **DeepL API key** (free or pro) from your DeepL account. You'll enter it after
  installation.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_node_translate_deepl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch Auto Node Translate
and the DeepL PHP library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/auto_node_translate_deepl -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with Auto Node Translate (Drupal will offer to enable the
dependency automatically):

```bash
drush en auto_node_translate_deepl -y
```

## What to do next

Before any translation can happen you must enter a valid DeepL API key on the
settings page — see [Configuration](../configuration/index.md). The language
mapping form in particular won't open until the key is valid, because it fetches
DeepL's list of supported languages live.
