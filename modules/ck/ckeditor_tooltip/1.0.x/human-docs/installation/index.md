# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — the only dependency. The
  tooltip dialog uses Drupal's built-in modal system, so no extra libraries are
  needed.

There are no third-party Composer packages or external JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_tooltip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_tooltip -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_tooltip -y
```

## Verify it worked

Enabling the module does not change the editor until you add the button per
format. Follow [Configuration](../configuration/index.md) to enable the Tooltip
plugin on a text format and grant the permission. Then edit some content, select
text, click the **Tooltip** button, and confirm the modal dialog opens and the
live preview responds as you change options.
