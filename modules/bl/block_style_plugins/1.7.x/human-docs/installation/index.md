# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Block** (`block`) and **Custom Block / Block Content** (`block_content`)
  modules — enabled automatically as dependencies.

No third‑party Composer or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/block_style_plugins -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/block_style_plugins -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_style_plugins -y
```

## Next step: define a style

On its own, this module adds no visible fields — it's an API. To see anything on
the block form you must define at least one `BlockStyle` plugin in a module or
theme (a `MYMODULE.blockstyle.yml` / `MYTHEME.blockstyle.yml` file is the quickest
route). See the [overview](../index.md#how-to-use-it) for a YAML example, and the
sibling [`agent/`](../agent/start.md) docs for the full plugin API.
