# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Block** module (`block`) enabled — this is the only dependency, and it is
  part of the standard Drupal install, so it is almost certainly already on.

There are no third‑party Composer or PHP library requirements. By default the widget's
JavaScript and flag images load from the GTranslate CDN; you can switch to serving them
locally from the module in the settings form if you prefer (for privacy or offline
use).

## Install with Composer

From the project root:

```bash
composer require drupal/gtranslate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gtranslate -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gtranslate -y
```

Enabling the module makes the **GTranslate** block available, but it isn't placed
anywhere yet, and nothing appears on the site until you do. Continue to
[Configuration](../configuration/index.md) to place the block, pick your languages,
and choose a widget style.

There are no submodules.
