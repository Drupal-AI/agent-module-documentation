# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The contributed **Admin Toolbar** module (`admin_toolbar`) — this is a required
  dependency, and it in turn depends on core's **Toolbar** module. Enabling
  Adminimal Admin Toolbar pulls both in automatically.

There are no third-party Composer packages or PHP libraries to install. (The Open
Sans webfont it uses is loaded from Google's CDN by the module's own stylesheet,
and can be turned off — see [Configuration](../configuration/index.md).)

> **Development release.** Version 2.0.x is a `dev` release. Review it before using
> it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/adminimal_admin_toolbar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Admin Toolbar and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/adminimal_admin_toolbar -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en adminimal_admin_toolbar -y
```

This also enables **Admin Toolbar** and core **Toolbar** if they aren't already
on. The dark styling is applied immediately for any user who can see the admin
toolbar — there is no required configuration.

There are no submodules.
