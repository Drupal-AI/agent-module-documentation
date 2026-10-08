# Installation

## Requirements

Text Resize is deliberately lightweight. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Block** module, which is part of the standard install and provides the
  block you place.

There are no third‑party Composer packages, PHP extensions, or contrib module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/text_resize -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/text_resize -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en text_resize -y
```

Or enable **Text Resize** from **Extend** (`/admin/modules`).

There are no submodules to consider.

## Next steps

Enabling the module does not put anything on the page by itself — you still need to
**place the block**. Head to [Configuration](../configuration/index.md) to place the
Text Resize block and adjust its behaviour.
