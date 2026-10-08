# Installation

## Requirements

- **Drupal 11.3 or later, or 12** (`core_version_requirement: ^11.3 || ^12`).
  This is an unusually tight requirement — it will not install on Drupal 11.2 or
  earlier. Check your core version first.
- Core's **Image** module (enabled on any standard site).

There are no third-party Composer or PHP library requirements — the baguetteBox
JavaScript library is a small, dependency-free (no jQuery) library shipped with
the module.

## Install with Composer

From the project root:

```bash
composer require drupal/baguettebox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/baguettebox -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en baguettebox -y
```

There is nothing to configure globally. To use it, go to an entity's **Manage
display** screen and set the **BaguetteBox** formatter on an image field — see
[How to use it](../index.md#how-to-use-it).
