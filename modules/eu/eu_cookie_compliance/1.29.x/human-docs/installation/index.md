# Installation

## Requirements

EU Cookie Compliance runs on **Drupal 8.9, 9, 10, or 11**
(`drupal/core: ^8.9 || ^9 || ^10 || ^11`). Its only module dependency is core's
**Filter** module (`filter`), which ships with Drupal and is enabled automatically.

An optional **klaro_migrator** submodule is included for sites that later want to
move their configuration to the Klaro module; you do not need it for normal setup.

## Install with Composer

From the project root:

```bash
composer require drupal/eu_cookie_compliance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eu_cookie_compliance -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eu_cookie_compliance -y
```

This enables the module along with core's `filter` dependency. Once enabled, the
banner configuration appears under **Configuration → System → EU Cookie
Compliance → Settings**
(`/admin/config/system/eu-cookie-compliance/settings`).

## Verify it worked

Log in as an administrator and go to
`/admin/config/system/eu-cookie-compliance/settings`. You should see the
**Settings** page with an **Enable banner** checkbox at the top and the
**Settings**, **Categories**, and **Translate eu cookie compliance** tabs:

![The EU Cookie Compliance Settings page](../images/settings.png)

If the page loads and those tabs are present, the module is installed correctly.
Next, work through the [configuration](../configuration/index.md) to enable the
banner and pick a consent model.
