# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** module (`image`) enabled (Drupal pulls it in as a dependency).
- A working **AI provider** for Drupal, configured with an API key — the module
  sends images to that provider's vision model to generate the text. Set this up
  as part of [Configuration](../configuration/index.md).

There are no third-party Composer or PHP library requirements declared by the
module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/alt_text_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alt_text_generator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alt_text_generator -y
```

Once enabled, connect an AI provider and its API key before generating any text —
see [Configuration](../configuration/index.md).
