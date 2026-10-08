# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **User** module (`user`), which is always part of a standard Drupal
  install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/force_password_change -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/force_password_change -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en force_password_change -y
```

The module creates a few of its own database tables on install to track
per‑role and per‑user state. It ships no submodules.

## Grant the permission

Assign the **Administer force changing of passwords** permission (machine name
`administer force password change`) to the roles that should manage this — usually
just administrators (and perhaps a helpdesk role). This single permission controls
the whole admin surface: the settings form, the role detail pages, and the
"force this user to change their password" checkbox on user edit forms. Ordinary
users need no permission — they are simply redirected to set a new password when a
change is pending.

## Verify it worked

Log in as an administrator and go to **Configuration → People → Force Password
Change** (`/admin/config/people/force_password_change`). You should see the
settings form. See [Configuration](../configuration/index.md) for how to use it.
