# Installation

## Requirements

- **Drupal 11.4 or 12** (`core_version_requirement: ^11.4 || ^12`).
- **Contrib module:** jQuery UI Selectmenu (`jquery_ui_selectmenu`), which
  provides the underlying widget. Composer installs it for you.

There are no PHP or third-party library requirements beyond that.

## Install with Composer

From the project root:

```bash
composer require drupal/select_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in jQuery UI
Selectmenu and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/select_icons -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en select_icons -y
```

## Verify it worked

Because Select Icons is a developer building block with no UI of its own, the way
to confirm it works is to use the element: add a `'#type' => 'select_icons'`
element to a form (with `#options`, `#options_attributes` carrying `data-class`
values, and a library providing the icon CSS) and load that form. The select
should render as a jQuery UI Selectmenu with your icons beside each option.
