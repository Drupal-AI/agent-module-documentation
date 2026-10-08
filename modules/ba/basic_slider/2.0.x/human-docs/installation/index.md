# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- Core's **Block** module (`block`), which Drupal enables automatically as a
  dependency.

There are no third‑party Composer or slideshow‑library requirements — the module
ships its own JavaScript.

## Install with Composer

From the project root:

```bash
composer require drupal/basic_slider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/basic_slider -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en basic_slider -y
```

Now place the **Basic Slider** block and add your images — see
[How to use it](../index.md#how-to-use-it).
