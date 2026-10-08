# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).

There are no third‑party Composer or PHP library requirements, no dependent
modules, and no permissions to configure.

## Install with Composer

From the project root:

```bash
composer require drupal/press_esc_to_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/press_esc_to_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en press_esc_to_login -y
```

There is nothing to configure — the module is active as soon as it is enabled.

## Verify it worked

Log out (or use a private/incognito window so you are anonymous) and press the
**Escape** key on any page. The browser should navigate to `/user`, the login
form. Log back in and confirm that pressing Escape no longer does anything — the
handler is attached only for anonymous visitors.

Remember the login path is hardcoded to `/user`; if you have remapped your login
URL, this shortcut will not reach it.
