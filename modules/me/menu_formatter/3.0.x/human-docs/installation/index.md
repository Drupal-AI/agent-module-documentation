# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Core's **Menu UI** module (`menu_ui`) — you will need it enabled; Drupal enables
  it as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_formatter -y
```

## Verify it worked

Add an entity-reference field that targets **Menu** entities to a content type,
then go to that content type's **Manage display**. In the field's **Format**
dropdown you should now see **Rendered Menu** as an option. Selecting it, adding a
menu reference to a piece of content, and viewing that content should render the
menu as a real navigation tree. See the [overview](../index.md#how-to-use-it) for
the full field setup.
