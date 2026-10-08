# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- Core's **Block** module (`block`) enabled — the only dependency, and part of a
  standard Drupal install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/faq_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/faq_block -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en faq_block -y
```

## Verify it worked

Go to **Structure → Block layout** and click **Place block** in any region. Search for
**FAQ Block** — if it appears in the list, the module is installed correctly. Placing
it opens the configuration form described in [Configuration](../configuration/index.md).
