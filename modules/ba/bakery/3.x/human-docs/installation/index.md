# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Two or more Drupal sites that **share a second-level domain** (for example
  `a.example.com` and `b.example.com`). Bakery's cookie is scoped to that shared
  domain — SSO across genuinely different domains is out of scope.
- The **same `bakery_key`** available to every site in the group (see
  [Configuration](../configuration/index.md)).

This is a **3.x dev** release. There are no third-party Composer or PHP library
requirements.

## Install with Composer

Install the module on the parent site **and** on each child site. From each
project root:

```bash
composer require drupal/bakery -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bakery -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

On each site:

```bash
drush en bakery -y
```

## Next: configure carefully

Bakery does nothing safe until it is configured. One site must be set as the
**parent** and the others as **children**, and all of them must share the same
secret `bakery_key`. Because that key is a master credential, read
[Configuration](../configuration/index.md) before you go live — how you store and
distribute the key is the whole security of the system.
