# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **AOS.js** library module (`aosjs`) — provides the Animate On Scroll library.
- The **AnimateCSS UI** module (`animatecss_ui`, part of the AnimateCSS project) — this
  module adds its AOS options to that UI.

Composer pulls in the dependent modules; enable them alongside this one.

## Install with Composer

From the project root:

```bash
composer require drupal/animatecss_aos -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/animatecss_aos -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en animatecss_aos -y
```

This also enables the AOS.js and AnimateCSS UI modules if they are not already on. The
AOS options then appear on the AnimateCSS add-animation form.
