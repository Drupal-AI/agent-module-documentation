# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module, which is part of a standard install.

There are no other dependencies, no third‑party libraries, and no special PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_exclude_pages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your host
> machine — `ddev composer require drupal/block_exclude_pages -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_exclude_pages -y
```

There are no submodules and nothing to configure. The moment it's enabled, **every** block's
**Pages** visibility setting understands the `!` exclusion syntax — there is no per‑block
opt‑in.

## After enabling

Edit any block's **Pages** visibility under **Structure → Block layout** and start using `!`
lines to exclude paths — see [How to use it](../index.md#how-to-use-it).
