# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **CKEditor 5**, enabled with at least one text format using it.
- Your content wrapper needs the `max-w-container` CSS class for the width presets
  to render correctly (see the main guide).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_max_block_width -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor5_max_block_width -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_max_block_width -y
```

## Verify it worked

Edit a CKEditor 5 text format at **Configuration → Content authoring → Text
formats and editors**, drag the **block width** dropdown onto the toolbar, and
save. Then edit content, select a table or image, pick a width from the dropdown,
and confirm the block's width changes on the rendered page (with the
`max-w-container` class present on the wrapper).
