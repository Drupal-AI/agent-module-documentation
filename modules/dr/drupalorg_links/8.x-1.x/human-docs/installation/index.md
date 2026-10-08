# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** and **Field UI** modules, so you can assign formatters on the
  *Manage display* tab (Field UI ships with Drupal core).

There are no third-party Composer or PHP library requirements, and no other
module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/drupalorg_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupalorg_links -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupalorg_links -y
```

## Verify it worked

Go to the **Manage display** tab of any entity that has a numeric field, open the
**Format** dropdown for that field, and confirm that **Comment link**, **Node
link**, and **User link** now appear as options. Pick one, save, and view an
entity to see the number render as a drupal.org link. See the
[main guide](../index.md) for the step-by-step setup.
