# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.2** or newer.
- The **OpenID Connect** module, version **3.x** (`drupal/openid_connect:^3`) —
  Composer pulls it in and Drupal enables it as a dependency.
- A **HarID** service registration (client id and secret) from harid.ee. Use
  `test.harid.ee` while developing.

## Install with Composer

From the project root:

```bash
composer require drupal/openid_connect_harid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies (such as OpenID Connect) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openid_connect_harid -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openid_connect_harid -y
```

Drupal enables the OpenID Connect module at the same time. There are no
submodules.

## Verify it worked

Go to **Configuration → People → OpenID Connect**
(`/admin/config/people/openid-connect`) and start adding a client — **HarID**
should now be one of the available client types. Continue in
[Configuration](../configuration/index.md).
