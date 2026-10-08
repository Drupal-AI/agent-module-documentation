# Installation

## Requirements

Module Filter **6.0.x** runs on **Drupal 11.4+ or 12** (`core_version_requirement:
^11.4 || ^12`). It builds on core's **System** module, which is always present.

Unlike the 5.0.x branch, 6.0.x has **no other dependencies at all** — the filter is
a from-scratch vanilla-JavaScript implementation, so there is no jQuery and no
`jquery_ui_autocomplete` contrib module to pull in.

> **Upgrading from 5.0.x?** 6.0.x is a major release. It drops Drupal 10 support and
> removes the `jquery_ui_autocomplete` dependency. If nothing else on your site uses
> `jquery_ui_autocomplete`, you can remove it after upgrading.

## Install with Composer

From the project root:

```bash
composer require drupal/module_filter
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/module_filter`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en module_filter -y
```

## Verify it worked

Log in as an administrator and go to the **Extend** page (`/admin/modules`). You
should now see a **filter / search field** at the top of the module list — start
typing a module name and the list narrows instantly. If the tabbed layout is in
place (it is on by default), packages appear as vertical tabs down the side.

Next, review the [configuration options](../configuration/index.md) to tune how the
enhancements behave.
