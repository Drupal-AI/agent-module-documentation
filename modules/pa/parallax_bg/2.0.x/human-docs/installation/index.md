# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's jQuery — the only dependency. There are no other modules and no third-party
  Composer or PHP libraries; the module bundles its own copy of the jQuery parallax
  plugin.

## Install with Composer

From the project root:

```bash
composer require drupal/parallax_bg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/parallax_bg -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en parallax_bg -y
```

## After enabling

Nothing changes until you create a Parallax element. Grant the **Administer parallax
elements** permission to the roles that should manage effects, then head to
[Configuration](../configuration/index.md) to create your first effect.
