# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no module dependencies (core only), no third‑party Composer libraries, and
no special PHP extensions.

## Install with Composer

From the project root:

```bash
composer require drupal/administerusersbyrole -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/administerusersbyrole -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en administerusersbyrole -y
```

There are no sub‑modules. Enabling the module changes nothing on its own — you still
have to classify your roles and grant permissions to the sub‑admin roles. See
[Configuration](../configuration/index.md).

> **Important:** this module is bypassed entirely for anyone holding core's
> **Administer users** or **Administer permissions**. Make sure your intended
> sub‑admin roles do **not** have those permissions, or the fine‑grained rules won't
> apply to them.
