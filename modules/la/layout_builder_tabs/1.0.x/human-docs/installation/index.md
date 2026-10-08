# Installation

## Requirements

Layout Builder Tabs is deliberately lightweight. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Layout Discovery** module (`layout_discovery`) — this is the only
  dependency, and Drupal enables it automatically when you turn on Layout Builder
  Tabs. (You will normally also be using core's **Layout Builder** module, since
  the Tabs section is only useful there.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_tabs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_tabs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_tabs -y
```

That is all it takes. The **Tabs** layout is now available in Layout Builder
under the *Extra Layouts* category. See the [overview](../index.md#how-to-use-it)
for how to add a Tabs section to a display.
