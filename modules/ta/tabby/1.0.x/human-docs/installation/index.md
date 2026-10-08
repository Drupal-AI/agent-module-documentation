# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other Drupal modules are required.
- The **Tabby JS library** — this is the JavaScript library Tabby renders with.
  See the module's own README for the exact Composer instructions for pulling in
  the library. (Note that Webform already bundles this library, so it may already
  be present on your site.)

There are no PHP extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tabby -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tabby -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

Follow the module's README to install the Tabby JS library if it is not already
present on your site.

## Enable the module

```bash
drush en tabby -y
```

## Verify it worked

Tabby has no admin page. It is working once it is enabled and the Tabby JS library
is available — render a `tabby_tabs` element (see the [main guide](../index.md)) or
enable a module that builds on it, such as Tabby Viewfield, and confirm the tabs
render and switch correctly.
