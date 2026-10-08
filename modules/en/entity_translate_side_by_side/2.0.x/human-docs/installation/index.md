# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A multilingual site with content translation set up — the module improves the
  translation experience for entity types you have made translatable using
  Drupal's core multilingual tools.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_translate_side_by_side -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_translate_side_by_side -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_translate_side_by_side -y
```

## Verify it worked

Open the edit page of a translatable entity (for example a node) and look at the
operations dropdown — you should see a **"Translate side by side"** option. Before
that works smoothly, set your default languages and grant the permission as
described in [Configuration](../configuration/index.md).
