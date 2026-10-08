# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — Drupal enables it as a dependency.

No separate Animate.css download is needed — `animate.min.css` is bundled with the
module.

## Install with Composer

From the project root:

```bash
composer require drupal/block_animate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_animate -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_animate -y
```

There is no configuration form. Once enabled, the animation options appear on each
block's configuration form under **Structure → Block layout** — see
[How to use it](../index.md#how-to-use-it).
