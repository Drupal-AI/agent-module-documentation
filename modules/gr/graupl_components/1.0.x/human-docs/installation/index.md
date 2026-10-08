# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **Graupl Libraries** (`graupl_libraries`) — provides the underlying
  accessible-menu JavaScript.
- Core's **Layout Builder** (`layout_builder`) and **Layout Discovery**.
- The **UI Patterns** module (`ui_patterns`).

There are no additional Composer or PHP library requirements.

> **Heads-up:** This module and the Graupl framework are at a very early stage
> of development and are **not recommended for production** until a stable
> release exists.

## Install with Composer

From the project root:

```bash
composer require drupal/graupl_components -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and will pull in Graupl Libraries and UI Patterns if
they aren't already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/graupl_components -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en graupl_components -y
```

Drupal enables Graupl Libraries, Layout Builder, Layout Discovery and UI
Patterns automatically as dependencies if they aren't on yet.

## Verify it worked

There is no settings page. Edit a layout with **Layout Builder** (or build with
UI Patterns) and confirm the Graupl components appear in the list of components
you can place.
