# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- An **Oracle Eloqua subscription** and an Eloqua application (client id/secret)
  set up for OAuth. Without an Eloqua account the module cannot do anything.

There are no other module dependencies. Note this project is *minimally
maintained* (maintenance fixes only), though it is covered by the Drupal Security
Team; the maintainers advise testing thoroughly before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/eloqua_api_redux -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eloqua_api_redux -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eloqua_api_redux -y
```

## Submodule

The project ships an optional submodule, **`eloqua_api_auth_fallback`**, which
provides an alternative authentication path. Enable it only if your setup needs
it:

```bash
drush en eloqua_api_auth_fallback -y
```

## Verify it worked

Go to **Configuration → Web services → Eloqua API Redux**
(`/admin/config/services/eloqua_api_redux`). The settings form should load, ready
for your Eloqua OAuth credentials — see [Configuration](../configuration/index.md).
