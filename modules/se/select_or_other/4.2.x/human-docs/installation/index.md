# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).

That is all. Select (or other) requires no modules outside Drupal core — no other
dependencies and no third‑party Composer or PHP library requirements. To use the
field widget you will of course want a List field or an entity‑reference/taxonomy
field to attach it to, both of which are core functionality.

## Install with Composer

From the project root:

```bash
composer require drupal/select_or_other -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/select_or_other -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en select_or_other -y
```

## No separate permissions

Select (or other) defines no permissions of its own. Who can choose the widget on a
field is governed by the usual core field/display permissions (such as *Administer
node form display*), and filling in a field is governed by the normal content edit
permissions.

## Verify it worked

Go to a content type's **Manage form display** tab and open the widget selector for
a List or entity‑reference field — **Select or Other** should appear as an option.
See the [overview](../index.md) for how to configure and use it.
