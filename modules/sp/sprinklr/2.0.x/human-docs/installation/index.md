# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9||^10||^11`).
- A **Sprinklr account** and the **App Id** for the chatbot you want to embed.
- No other module dependencies and no PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/sprinklr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sprinklr -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sprinklr -y
```

## After installing

Open the module's settings, enter your Sprinklr **App Id**, and choose the pages
and content types where the chatbot should appear — see
[Configuration](../configuration/index.md).

## Verify it worked

Visit one of the pages you enabled the chatbot for. The Sprinklr chat widget
should load and be usable by visitors.
