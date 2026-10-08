# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Image** module enabled — the module's only dependency, and Drupal
  enables it automatically. The decorative option only applies to `image`-type
  fields.

There are no third-party Composer or PHP library requirements, and no permissions
to grant.

## Install with Composer

From the project root:

```bash
composer require drupal/decorative_images -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/decorative_images -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en decorative_images -y
```

There's no settings page. Next, enable the decorative option on the image field(s)
where you want it — see [Configuration](../configuration/index.md).
