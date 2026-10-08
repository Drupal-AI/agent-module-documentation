# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Analyze** module (`analyze`, version 1.3.0 or newer) — the framework this plugs
  into.
- The **Views Color Scales** module (`views_color_scales`, 1.1.0 or newer).
- The **AI** module (`ai`) with a working chat AI provider configured.

## Install with Composer

From the project root:

```bash
composer require drupal/analyze_ai_sentiments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/analyze_ai_sentiments -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en analyze_ai_sentiments -y
```

This also enables the Analyze, Views Color Scales, and AI modules if they are not
already on. Next, follow [Configuration](../configuration/index.md) to connect an AI
provider and turn the analyzer on for the content types you want assessed.
