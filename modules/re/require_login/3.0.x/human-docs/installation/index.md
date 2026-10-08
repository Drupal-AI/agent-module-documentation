# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **User** module (`user`), which is always part of a Drupal install.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/require_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/require_login -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en require_login -y
```

> **Heads up — this gates the whole site immediately.** With its default settings,
> Require Login forces authentication on **every** page the moment it's enabled.
> Anonymous visitors can only reach the login, registration, and password-reset
> pages (plus the assets needed to display them). Make sure you have a working
> logged-in admin session before or right after enabling, so you don't lock
> yourself out. Any authenticated user can browse normally; there's no special
> "bypass" permission — being logged in is the bypass.

No submodules ship with this project.

## Next step

Head to [Configuration](../configuration/index.md) to narrow where login is
required and set the login path, message, and post-login destination.

## Verify it worked

In a private/incognito window (logged out), visit any page of your site. You should
be redirected to the login page. After logging in, you should be returned to the
page you originally requested.
