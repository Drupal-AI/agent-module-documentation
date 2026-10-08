# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`) — enabled by default on most sites.
- The **jQuery UI** module (`jquery_ui`) — a contributed dependency used for the
  draggable behaviour, installed automatically by the Composer command below.

## Install with Composer

From the project root:

```bash
composer require drupal/floating_sticky_notes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `jquery_ui`
dependency and any shared libraries alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/floating_sticky_notes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en floating_sticky_notes -y
```

Drupal enables the required **Block** and **jQuery UI** modules as dependencies if
they are not already on.

## Verify it worked

Go to **Structure → Block layout** and confirm the **Sticky Notes Block** is
available to place. After placing it and granting the permission (see "How to use
it" on the [overview page](../index.md)), a sticky-notes icon should appear on the
page, and the listing at **Content → Sticky notes** should load.
