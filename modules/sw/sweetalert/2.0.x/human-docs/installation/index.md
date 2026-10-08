# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No other Drupal module dependencies.
- The **SweetAlert2** JavaScript library, installed into your site's `libraries`
  directory. The 2.x branch uses SweetAlert2, and the currently supported library
  version is **11.x**. The module checks for the library at install time.

## Install the SweetAlert2 library

Download `sweetalert2.all.min.js` from the SweetAlert2 releases page
(<https://github.com/sweetalert2/sweetalert2/releases>) and place it so the file
is available at:

```
(webroot)/libraries/sweetalert2/sweetalert2.all.min.js
```

Without the library present, the module has nothing to fire and the install check
will flag it.

## Install the module with Composer

From the project root:

```bash
composer require drupal/sweetalert -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sweetalert -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sweetalert -y
```

## Verify it worked

Go to the demo sandbox at
**Configuration → User interface → SweetAlert → Sandbox**
(`/admin/config/user-interface/sweetalert/sandbox`), enter a title and message,
and submit. If a styled SweetAlert2 dialog appears, the library and module are
wired up correctly. If you instead see a plain browser alert or nothing at all,
the SweetAlert2 library is almost certainly missing from `/libraries/sweetalert2`.
