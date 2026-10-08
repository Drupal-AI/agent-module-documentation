# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement: ^10.3 ||
  ^11`).
- Core's **Block** module (`block`), enabled automatically as a dependency.

There are no third-party libraries and **no API key** — the module loads Google
Translate's public browser script directly, so nothing needs to be provisioned
with Google.

## Install with Composer

From the project root:

```bash
composer require drupal/google_translator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/google_translator -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_translator -y
```

After enabling, choose your languages on the settings form and place the block —
see [Configuration](../configuration/index.md).

This module has no submodules.
