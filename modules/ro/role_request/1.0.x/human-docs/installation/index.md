# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **User** module (`user`), which is part of a standard Drupal install.
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/role_request -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/role_request -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en role_request -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → People → Role request**
(`/admin/config/people/role-request`). If the settings form loads, the module is
ready — continue to [Configuration](../configuration/index.md) to choose which roles
can be requested and to set permissions carefully.
