# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Link** module (`link`) — Link tree extends it.
- The **Linkit** contrib module (`linkit`) — used for link autocomplete.

Both dependencies are declared, so Composer and Drupal pull them in for you when
you install and enable Link tree. There are no third-party PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/link_tree -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed — here it also brings in Linkit if you don't already have
it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/link_tree -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_tree -y
```

Drupal enables **Link** and **Linkit** automatically as dependencies if they are
not already on.

## Verify it worked

Go to **Structure → *(a content type)* → Manage fields → Add field**. The field
type list should now include **Link tree**. Add one to a test bundle, set it to
allow multiple values, then edit a piece of content — you should be able to add
several links, drag to reorder them, and indent items to build a nested tree.
