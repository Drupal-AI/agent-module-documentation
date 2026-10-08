# Installation

## Requirements

jQuery UI Touch Punch is a library provider with one external JavaScript
dependency. It needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The base **jQuery UI** module (`jquery_ui`, `^1.0`) — its library depends on
  `jquery_ui/core`. Composer and Drupal pull it in automatically.
- The external **Touch Punch** JavaScript library
  (`politsin/jquery-ui-touch-punch`, `^1.0`). Composer installs this into your
  site's `/libraries` directory — it ends up at
  `/libraries/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js`. Using the
  Composer command below (with `-W`) is the simplest way to get it in place.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_touch_punch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the required
`drupal/jquery_ui` module and the external `politsin/jquery-ui-touch-punch`
JavaScript library (and update any shared dependencies) for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jquery_ui_touch_punch -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_touch_punch -y
```

Drupal enables the base `jquery_ui` module at the same time if it isn't already
on. As soon as it is enabled — and provided the external Touch Punch JavaScript
is present in `/libraries` — the `jquery_ui_touch_punch/touch-punch` library is
available for any module or theme to depend on or attach. There is no required
configuration and no settings form to visit.
