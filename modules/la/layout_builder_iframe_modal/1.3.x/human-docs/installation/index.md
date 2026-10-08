# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal will enable it as a dependency when you turn on this
  module.

There are no third-party PHP library or Composer requirements. The module is
compatible with the `layout_builder_st` (Layout Builder Symmetric Translations)
routes if you use them, and works as a drop-in alternative to `layout_builder_modal`
when you want admin-theme isolation via an iframe rather than in-page rendering.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_iframe_modal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_iframe_modal -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_iframe_modal -y
```

The module ships no submodules. Once enabled, all ten built-in Layout Builder edit
routes immediately open in the admin-themed iframe modal — there is nothing you
*must* configure. Grant the **Configure layout builder iframe modal** permission
to any non-administrator role that should be able to change the route list, then
see [Configuration](../configuration/index.md) if you want to adjust which routes
use the modal.
