# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other Drupal module dependencies.
- The **SweetAlert2** JavaScript library, installed separately (the module does
  **not** bundle it). The module's install hook checks that the library files are
  present.

Note that this project is **not covered by Drupal's security advisory policy**.

## Install the SweetAlert2 library

Download the SweetAlert2 library and place it under your site's `libraries`
directory. The expected path depends on your Drupal version:

- **Drupal 9 and earlier:** `/libraries/sweetalert2/sweetalert2.all.js`
- **Drupal 10 and later:** `/libraries/sweetalert2/dist/sweetalert2.all.js`

If enabling the module leaves your dialogs looking like plain browser alerts,
check that the library is at the correct path for your Drupal version — a missing
or misplaced library is by far the most common cause.

## Install the module with Composer

From the project root:

```bash
composer require drupal/sweetalert2 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sweetalert2 -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sweetalert2 -y
```

Remember that enabling the module alone changes nothing on the front end — a theme
or module must attach the library and call `Swal.fire()`. See the
[main guide](../index.md) for how to use it.

## Verify it worked

Check **Reports → Status report** (`/admin/reports/status`) — the module's install
check reports whether the SweetAlert2 library was found. If it flags the library
as missing, revisit the library path above.
