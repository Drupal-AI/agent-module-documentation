# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Block** (`block`), **Block Content** (`block_content`), and **Layout
  Discovery** modules.
- The contrib **Inline Entity Form** (`inline_entity_form`) module.
- **Some custom code.** As the module's own documentation states, getting it
  working requires basic programming in a custom module (typed entity classes for
  your block types) — this is not a no‑code module.

## Install with Composer

From the project root — this pulls in Inline Entity Form alongside Layout Block:

```bash
composer require drupal/layout_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_block -y
```

Drupal will enable the required core modules and Inline Entity Form as
dependencies.

## Verify it worked

After enabling, follow the module's bundled **`README.txt`**: switch the Layout
Builder widget to **"Layout Builder Asymmetric Translation (layout_block
support)"** and add the custom typed entity classes for your block types. Only once
those steps are done will layout‑backed block types behave as intended — see the
overview's "How to use it".
