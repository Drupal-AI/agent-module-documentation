# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- Core's **Node** (`node`) and **Dynamic Page Cache** (`dynamic_page_cache`) modules.
- The **Token** module (`token`).
- An **AI Sidekick account and API key**. There is a free account to start with, but
  for daily use you will want an API key; you can explore plans at
  [ai-sidekick.app/en/pricing](https://ai-sidekick.app/en/pricing).

## Install with Composer

From the project root:

```bash
composer require drupal/sidekick -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Token module if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sidekick -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sidekick -y
```

Drupal enables the Node, Dynamic Page Cache, and Token dependencies automatically.

## Next step

Enabling the module is not enough — you need to enter your API key and decide who may
generate content. Continue to [Configuration](../configuration/index.md).
