# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Breakpoint** module (`breakpoint`) — Drupal enables it as a dependency.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_breakpoint -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_breakpoint -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_breakpoint -y
```

There is no configuration form. Once enabled, the breakpoint condition appears on
each block's configuration form under **Structure → Block layout** — see
[How to use it](../index.md#how-to-use-it).
