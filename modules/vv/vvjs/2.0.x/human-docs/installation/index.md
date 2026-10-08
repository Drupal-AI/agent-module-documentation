# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12`).
- **PHP 8.3** or newer.
- Core's **Views** (`views`) and **Filter** (`filter`) modules.
- The **VVJ Core** foundation module (`vvj_core`, `^2.0`) — Composer installs it
  as a dependency, and VVJS's update hook enables it automatically when you run
  database updates.

No JavaScript libraries need to be downloaded — the slideshow code ships with the
module.

## Install with Composer

From the project root:

```bash
composer require drupal/vvjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `vvj_core` and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/vvjs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en vvjs -y
```

This enables VVJS and its `vvj_core` dependency. An optional sample view
(`vvjs_example`) installs automatically if there is no id conflict, so you have a
working example to learn from.

## Upgrading from VVJS 1.x

Version 2 is a drop-in upgrade — the plugin id (`views_vvjs`), all option keys,
the library names, and CSS class names are unchanged (the only rendered change is
the outer element tag). Update in place with:

```bash
composer update drupal/vvjs -W
drush updb -y
drush cr
```

`drush updb` runs the update hook that enables the new `vvj_core` dependency.
