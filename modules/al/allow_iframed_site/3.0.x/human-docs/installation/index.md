# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No contrib module dependencies — it needs only Drupal core.

There are no third-party Composer or PHP library requirements, and the module adds
no permissions of its own (its form uses core's **Administer site configuration**
permission).

## Install with Composer

From the project root:

```bash
composer require drupal/allow_iframed_site -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/allow_iframed_site -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en allow_iframed_site -y
```

Enabling the module changes nothing on its own — until you list at least one path
(or enable negate), it leaves the `X-Frame-Options` header in place, so all your
pages remain framing-protected. Continue to
[Configuration](../configuration/index.md) to choose which pages may be embedded.
