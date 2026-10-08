# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **The [Paragraphs](https://www.drupal.org/project/paragraphs) module, version
  1.6 or newer** (`drupal/paragraphs:^1.6`). This is the module's one dependency
  — Composer pulls it in for you if it isn't already installed.

There are no other third-party Composer or PHP library requirements, and the
module adds no permissions or config schema of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_role_visibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install or update the
Paragraphs dependency and any shared libraries as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_role_visibility -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_role_visibility -y
```

There is no settings page to configure. Once enabled, turn on the **Paragraph
visibility** behavior for the paragraph types you want to control (*Structure →
Paragraphs types → edit → Behaviors*), then set roles on individual paragraphs from
their *Behavior* tab — see the [overview](../index.md#how-to-use-it) for the full
walkthrough.

This module has no submodules.
