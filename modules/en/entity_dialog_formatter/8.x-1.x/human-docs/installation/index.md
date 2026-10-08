# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Field** module (`field`) — part of standard Drupal installs and enabled
  as a dependency.
- **No extra JavaScript library** is required; the modal comes from Drupal core.
- Works with **content entities** only.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_dialog_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_dialog_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_dialog_formatter -y
```

Note that this release line is a **beta** (`8.x-1.1-beta1`); test it before relying
on it in production.

## Verify it worked

Go to **Structure → (an entity type) → Manage display** for a bundle that has an
entity reference field, and confirm the dialog/modal formatter appears as an
available format. Selecting it, configuring the page and dialog view modes, and
viewing the entity should let you click the reference to open it in a modal.
