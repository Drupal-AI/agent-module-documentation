# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 | ^11`).
- Core's **Block** (`block`) and **Config** (`config`) modules — both standard core
  modules, enabled as dependencies.

No external libraries or PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_social_share -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name, `drupal/simple_social_share`,
matches the module's machine name.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_social_share -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_social_share -y
```

## Place and configure the block

Nothing appears until you place the block. Go to **Structure → Block layout**
(`/admin/structure/block`), place the **Simple Social Share** block in your chosen
region, enable the platforms you want, optionally turn on the **Copy Link** button,
and save. See the **How to use it** section of the [main guide](../index.md) for the
walkthrough.
