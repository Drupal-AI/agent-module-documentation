# Installation

## Requirements

Layout Builder Shortcuts is a lightweight enhancement for core Layout Builder. It
needs:

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Core's **Layout Builder** module (`layout_builder`) enabled.
- Core's **Block** module (`block`) enabled.

Drupal will enable both dependencies (and their own dependencies) automatically when
you turn on this module. There are no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_shortcuts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_shortcuts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_shortcuts -y
```

That's all it takes. It works out of the box — there is no configuration.

## Verify it worked

Edit a page that uses Layout Builder. The blocks in the layout should now offer an
inline edit shortcut that opens a block's configure/edit form in fewer clicks than
before.
