# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which Drupal enables automatically as a
  dependency.
- **Font Awesome** — the icon formatter relies on Font Awesome. The module can
  attach its own bundled Font Awesome library, or you can let your theme provide
  it (see [Configuration](../configuration/index.md)).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/social_link_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/social_link_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_link_field -y
```

There are no submodules. Once enabled, the **Social Links** field type is
available when you add a field to any bundle — see
[Configuration](../configuration/index.md).
