# Installation

## Requirements

- **Drupal 10.2 or newer, or Drupal 11** (`core_version_requirement: ^10.2 ||
  ^11`).
- Core's **User** and **Path alias** modules (`user`, `path_alias`), both enabled
  automatically as dependencies.

There are no third-party libraries. A few optional modules make it nicer but are
not required:

- **Token** (`drupal/token`) — lets you use tokens such as `[current-user:uid]`
  inside a role's Redirect URL.
- **Commerce** — the module automatically skips the Commerce checkout route so
  checkout is never interrupted.
- **CAS** — redirects apply to CAS single-sign-on logins too.

## Install with Composer

From the project root:

```bash
composer require drupal/login_redirect_per_role -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To add the optional Token support:

```bash
composer require drupal/token -W
drush en token -y
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/login_redirect_per_role -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_redirect_per_role -y
```

Enabling it changes nothing until you configure a redirect. Head to
[Configuration](../configuration/index.md) to set up your login and logout
landing pages.

This module has no submodules.
