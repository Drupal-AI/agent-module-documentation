# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **User** module (`user`) — this is a declared dependency and is part of
  standard Drupal, so it is already enabled.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/temp_admin_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/temp_admin_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en temp_admin_login -y
```

## Verify it worked

Log in as a user with the **Administer site configuration** permission and go to
**Configuration → System → Generate Temporary Admin Login Link**. You should see the
form for choosing a role and expiry time and generating a link. (Remember: the
generated link logs the visitor in as super‑admin whatever role you choose.)
