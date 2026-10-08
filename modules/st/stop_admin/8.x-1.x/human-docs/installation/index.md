# Installation

## Before you enable it — read this

If you turn this module on and you do **not** have command-line (Drush) access to
the site, you will not be able to log back in as user 1. Protect yourself first:

- Make sure you have a **personal administrator account** (not user 1) with enough
  permissions to run the site.
- If you plan to also block the whole administrator role, make sure some *other*
  role has the permissions needed to manage the site.
- Keep Drush access available as your emergency route back in.

The project's recovery documentation is at
<https://www.drupal.org/docs/contributed-modules/stop-administrator-login>.

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No other modules or libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/stop_admin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/stop_admin -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en stop_admin -y
```

## Verify it worked

Log out and try to sign in through the login form as user 1. You should be turned
away with the generic *"Unrecognized username or password"* message. Remember the
important caveat from the [main guide](../index.md): this only blocks the login
*form* — API login endpoints, one-time login links, and basic-auth/SSO paths are
not affected. If you need the account to be truly unusable, block the account
itself rather than relying on this module alone.
