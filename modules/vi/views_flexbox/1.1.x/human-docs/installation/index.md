# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Views** module (`views`) — enabled on any standard site, and pulled in
  as a dependency.

No contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/views_flexbox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_flexbox -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_flexbox -y
```

There is no configuration form. The **Flexbox** style becomes available in the Views
UI immediately — set it on a display's **Format**, as described on the
[overview page](../index.md#how-to-use-it).
