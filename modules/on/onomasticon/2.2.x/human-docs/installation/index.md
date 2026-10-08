# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other contributed modules are required — the glossary is built on core's
  Taxonomy, Filter and (for the exclude button) CKEditor, all of which ship with
  Drupal.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/onomasticon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/onomasticon -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en onomasticon -y
```

The module ships no submodules. Once enabled, build a glossary vocabulary and turn
the filter on for a text format — see the [main guide](../index.md#how-to-use-it).
Remember the filter is a silent no‑op until you choose a vocabulary in its
settings.
