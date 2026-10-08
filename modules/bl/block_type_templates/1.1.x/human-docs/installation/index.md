# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No modules, PHP libraries, or Composer dependencies. It builds on core's block and
  theming systems (content blocks come from core's Block Content module, which is
  usually already on).

## Install with Composer

From the project root:

```bash
composer require drupal/block_type_templates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_type_templates -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_type_templates -y
```

There is nothing to configure — the template suggestions and CSS classes are active
immediately.

## Verify it worked

Enable Twig debugging and view a page that renders a content block. In the page
source you should see the new `block--block-content-<type>` entries in the block's
`FILE NAME SUGGESTIONS` comment. Then add a matching template in your theme as
described on the [main page](../index.md#how-to-use-it). Remember to run `drush cr`
after adding the template file.
