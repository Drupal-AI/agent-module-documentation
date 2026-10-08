# Installation

## Requirements

Layout Builder Title Link extends core Layout Builder. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Layout Builder** module (`layout_builder`) installed and enabled — you
  need Layout Builder active to use this module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_title_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_title_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_title_link -y
```

That's all it takes. No admin configuration is required.

## Verify it worked

Edit a page that uses Layout Builder, then add or configure a block. In the block
configuration form you should see a new **URL** field for the title. Enter a URL,
save the block and the layout, and the block's title should render as a link.
