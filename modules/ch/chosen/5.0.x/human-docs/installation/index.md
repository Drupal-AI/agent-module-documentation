# Installation

## Requirements

Chosen needs **Drupal 10.2+ or 11**. It has no other contrib module dependencies
of its own, but it does rely on two things that are installed alongside it:

- **Chosen library submodule** (`chosen_lib`) — ships with the Chosen project and
  provides (or downloads) the third-party Chosen JavaScript assets. The main
  `chosen` module depends on it, so it is enabled automatically.
- **The Chosen JavaScript library** (`noli42/chosen`, version 3.1.3) — the actual
  JS/CSS plugin. This is a front-end library that is **not** bundled with the
  Drupal module; you obtain it separately (see
  [Get the Chosen JavaScript library](#get-the-chosen-javascript-library) below).

The project also includes an optional `chosen_field` submodule, which adds a
dedicated field widget so editors can opt individual reference or list fields into
Chosen. You do not need it for site-wide behavior; enable it only if you want
per-field control.

## Install with Composer

From the project root:

```bash
composer require drupal/chosen -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/chosen -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chosen -y
```

Enabling `chosen` also enables its required `chosen_lib` submodule. Once enabled,
the settings screen appears under **Configuration → User interface → Chosen**
(`/admin/config/user-interface/chosen`).

## Get the Chosen JavaScript library

The Drupal module supplies the integration code, but the Chosen library's own
JavaScript and CSS files must be present on the server before the enhanced selects
will render. The `chosen_lib` submodule provides a Drush command to fetch them for
you:

```bash
drush chosen:plugin
```

This downloads the Chosen library into your site's `libraries/` directory. If you
prefer not to use Drush — or your server has no outbound access — you can download
the library manually and place it in `libraries/chosen` instead.

> **Using DDEV?** Run the download inside the project so the files land in the
> container: `ddev drush chosen:plugin`.

## Verify it worked

Log in as an administrator and go to `/admin/config/user-interface/chosen`. You
should see the **Chosen** settings form:

![The Chosen settings page](../images/settings.png)

If the page loads with the option-threshold selects, width fields, and the
**Apply Chosen to the following elements** box, the module is installed correctly.
Next, review the [configuration settings](../configuration/index.md) to control
exactly which selects Chosen enhances.
