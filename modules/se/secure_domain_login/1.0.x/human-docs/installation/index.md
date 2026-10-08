# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other modules, PHP libraries, or third-party services are required.

The module defines one permission, **Administer secure domain login configuration**,
which gates its settings form.

## Install with Composer

From the project root:

```bash
composer require drupal/secure_domain_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/secure_domain_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en secure_domain_login -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Important: configure the whitelist right away

As soon as the module is enabled its response guard is active, and an **empty
whitelist means no host is allowed** — which redirects *all* `/user` traffic,
including the login form itself, to the front page. Go straight to
[Configuration](../configuration/index.md) and enter your allowed host(s) before you
rely on the module, so you do not lock yourself out.

This project is **not covered by Drupal's security advisory policy**, and the Host-header
check is a soft deterrent only — see the main guide.
