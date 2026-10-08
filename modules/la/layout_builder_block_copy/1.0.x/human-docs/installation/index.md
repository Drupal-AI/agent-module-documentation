# Installation

## Requirements

- **Drupal 10.3 or higher** (`core_version_requirement: ^10.3 || ^11`; Drupal 11
  compatible).
- Core's **Layout Builder** (`layout_builder`) module must be enabled.
- Core's **Block Content** (`block_content`) module.

There are no contrib dependencies beyond Drupal core, and no third‑party PHP
library requirements.

> **Note:** this module is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_block_copy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_builder_block_copy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_block_copy -y
```

Drupal will enable Layout Builder and Block Content as dependencies if they are not
already on.

## Verify it worked

Edit a Layout Builder layout, open the contextual menu on an inline block, and
confirm a **Copy block** action appears. Use it, and check that the copy is an
independent block — editing it does not change the original. See the overview's
"How to use it".
