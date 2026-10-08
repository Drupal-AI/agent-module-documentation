# Installation

## Requirements

jQuery UI Tabs is a tiny library companion. It needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **jQuery UI** base module (`drupal/jquery_ui`, `^1.7`) — this is the only
  dependency. It declares the actual tabs library and provides the shared jQuery
  UI assets. Composer pulls it in automatically.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_tabs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including the `drupal/jquery_ui` base module) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_ui_tabs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_tabs -y
```

Enabling it also enables the `jquery_ui` base module if it is not already on.

## Submodules

jQuery UI Tabs ships **no submodules**.

## Verify it worked

There is no UI to check. Attach `jquery_ui_tabs/tabs` to a render array (or
depend on it from a `*.libraries.yml`) and confirm the tabs JavaScript and CSS
load on the page. Because jQuery UI is End‑of‑Life upstream, treat this as a
bridge for legacy code rather than a dependency for new work.
