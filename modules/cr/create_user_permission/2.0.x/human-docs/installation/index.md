# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **User** module (`user`), which is enabled on every Drupal site. This is
  the only dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/create_user_permission -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/create_user_permission -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en create_user_permission -y
```

## Grant the permission

Enabling the module adds the new **Create users** permission but does not give it
to anyone yet. Complete the setup by granting it:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. In the **Create User Permission** section, tick **Create users** for the roles
   that should be able to create accounts.
3. Click **Save permissions**.

See [How to use it](../index.md#how-to-use-it) in the main guide for what the
permission does and does not allow.
