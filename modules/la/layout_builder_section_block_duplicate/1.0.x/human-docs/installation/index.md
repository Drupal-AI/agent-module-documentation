# Installation

## Requirements

Layout Builder Section-Block Clone extends core Layout Builder. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal will enable it (and its own dependencies) automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_section_block_duplicate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_section_block_duplicate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_section_block_duplicate -y
```

That's all it takes. It works out of the box — there is no configuration.

## Verify it worked

Edit a page that uses Layout Builder. Hover over a section and you should see a
**Clone section** link; open a block's contextual links and you should see a
**Clone block** action. Using either should place a duplicate immediately after the
original, preserving all settings.
