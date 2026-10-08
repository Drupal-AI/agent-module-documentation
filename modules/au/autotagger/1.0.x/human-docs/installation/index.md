# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) — Drupal enables it automatically as a
  dependency.
- A **tagging plugin**: autotagger is only the core framework. To actually tag
  anything you also need a submodule that supplies matching logic (for example a
  search‑in‑text keyword matcher) or a custom plugin you write. Without one, the
  framework has nothing to tag with.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/autotagger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autotagger -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autotagger -y
```

Once enabled, configure an auto‑tagging action and pair it with a tagging plugin —
see [How to use it](../index.md#how-to-use-it) on the overview page.
