# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** module (`drupal/ai`, `^1`) — this is a hard dependency and provides the
  connection to your LLM provider. You must configure a provider in it before AI SEO
  can run (see [Configuration](../configuration/index.md)).
- The **`league/commonmark`** PHP library (`^2.5`) — used to render the Markdown the
  model returns into HTML. It comes in automatically via Composer.

Installing the module with Composer (below) pulls in the AI module and
`league/commonmark` automatically.

## Install with Composer

Always install this module with Composer so its dependencies come along. From the
project root:

```bash
composer require drupal/ai_seo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_seo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_seo -y
```

Drush enables the AI module as a dependency. Before you can generate a report you
must configure an AI provider and pick a model — continue with
[Configuration](../configuration/index.md).
