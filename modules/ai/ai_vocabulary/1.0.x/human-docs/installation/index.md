# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) — the generated vocabularies and terms
  live here.
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`), configured with
  a working AI provider (this is what actually generates the terms).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_vocabulary -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_vocabulary -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_vocabulary -y
```

This ensures `taxonomy` and `ai` are enabled too. After enabling, set up the
default provider and grant permissions in [Configuration](../configuration/index.md).
