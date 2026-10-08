# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11**
  (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).

There are no module dependencies and no third-party Composer or PHP library
requirements — the module is entirely self-contained.

## Install with Composer

From the project root:

```bash
composer require drupal/httpswww -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/httpswww -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en httpswww -y
```

There are no submodules.

## A key point about the default state

The module ships **no default configuration**. Immediately after enabling it, the
redirect does nothing — it is effectively off until you visit the settings form and
turn it on. So enabling the module is safe; nothing changes until you configure it.

## Grant the permissions

Both of the module's permissions are flagged security-sensitive and are granted to
no role by default. Before you configure anything, give a trusted administrator role
the *Bypass HTTPS and WWW Redirects* permission so you cannot lock yourself out
mid-change, and the *Administer HTTPS and WWW Redirects* permission so someone can
edit the settings. See [Configuration](../configuration/index.md) for details.

## Verify it worked

Visit **Configuration → System → HTTPS and WWW Redirect**
(`/admin/config/system/httpswww`). You should see the settings form with the
**Enable redirects** switch and the WWW/HTTPS options.
