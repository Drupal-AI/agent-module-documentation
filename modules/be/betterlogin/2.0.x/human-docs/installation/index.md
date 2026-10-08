# Installation

## Requirements

Better Login is deliberately lightweight. It needs:

- **Drupal 10.1 or newer, or Drupal 11** (`core_version_requirement:
  ^10.1 || ^11`).
- Core's **User** module, which every Drupal site already has enabled.

There are no third-party Composer packages, no PHP library requirements and no
other contrib modules to install first.

## Install with Composer

From the project root:

```bash
composer require drupal/betterlogin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/betterlogin -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en betterlogin -y
```

That's all it takes. There is no configuration step. As soon as the module is
enabled, the login, registration, password-request and password-reset pages are
restyled.

## Verify it worked

Log out (or open a private/incognito window) and visit `/user/login`. Instead of
your normal theme with a form inside it, you should see a standalone sign-in card
showing the site logo and name, with the username field already focused and a
"Forgot your password?" link. The login/register/password tabs should be gone.

There are no submodules and nothing further to configure. If you want to change
the look, see the "Changing the look" section on the [overview page](../index.md).
