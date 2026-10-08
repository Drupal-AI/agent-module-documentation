# Installation

## Requirements

Module Filter runs on **Drupal 10, 11, or 12** (`core_version_requirement:
^10 || ^11 || ^12`). It builds on core's **System** module, which is always
present.

Because Drupal 10 removed the bundled jQuery UI, Module Filter also needs one
contrib module, which Composer pulls in automatically:

- **jQuery UI Autocomplete** (`jquery_ui_autocomplete`, `^2.1`) — provides the
  autocomplete behaviour the filter box relies on.

## Install with Composer

From the project root:

```bash
composer require drupal/module_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer add or update the
`jquery_ui_autocomplete` dependency as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/module_filter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en module_filter -y
```

This also enables the `jquery_ui_autocomplete` dependency.

## Verify it worked

Log in as an administrator and go to the **Extend** page (`/admin/modules`). You
should now see a **filter / search field** at the top of the module list — start
typing a module name and the list narrows instantly. If the tabbed layout is in
place (it is on by default), packages appear as vertical tabs down the side.

Next, review the [configuration options](../configuration/index.md) to tune how the
enhancements behave.
