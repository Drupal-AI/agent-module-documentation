# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No modules outside Drupal core, and no third‑party Composer or PHP libraries.

> **Important:** In the 2.0.x release, Remix is a **placeholder** — its functional
> code was relocated to the
> [Decoupled Preview Iframe](https://www.drupal.org/project/decoupled_preview_iframe)
> module. Installing Remix will not provide a working Drupal ↔ Remix integration.
> If you want the actual features, install Decoupled Preview Iframe instead.

## Install with Composer

From the project root:

```bash
composer require drupal/remix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/remix -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en remix -y
```

## Verify it worked

The module will enable without error, but because it is a placeholder there is no
feature to observe. To get real functionality, install and configure
[Decoupled Preview Iframe](https://www.drupal.org/project/decoupled_preview_iframe).
