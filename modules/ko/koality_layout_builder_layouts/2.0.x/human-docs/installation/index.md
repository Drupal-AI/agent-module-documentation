# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Layout Builder** module (`layout_builder`) enabled — the only
  dependency, and Drupal enables it automatically as a dependency.

There are no third‑party Composer or PHP library requirements. (Note this branch
is *minimally maintained* and declares core up to Drupal 10; check the project
page for Drupal 11 status before using it there.)

## Install with Composer

From the project root:

```bash
composer require drupal/koality_layout_builder_layouts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/koality_layout_builder_layouts -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en koality_layout_builder_layouts -y
```

Enabling it will also enable core Layout Builder if it isn't already on.

## Verify it worked

Edit any Layout Builder layout (for example on a content type where Layout Builder
is enabled) and click **Add section**. The Koality **1, 2, 3, and 4 column**
layouts should appear in the layout picker. If they do, the module is installed
and ready — there is nothing further to configure. See the main
[guide](../index.md#how-to-use-it) for using the per‑section width, spacing, and
background‑colour options.
