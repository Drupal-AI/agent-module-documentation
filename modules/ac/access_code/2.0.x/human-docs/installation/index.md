# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **User** module (`user`), which is always present on a Drupal site.
- No third-party Composer or PHP library requirements are declared.

## Install with Composer

From the project root:

```bash
composer require drupal/access_code -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/access_code -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en access_code -y
```

## Set the permissions

Under **People → Permissions**, assign the module's two permissions:

- **`change any access code`** — lets a user set or change the access code for any
  account. Keep this with trusted staff who administer accounts.
- **`change own access code`** — lets a user change only their own access code.

## Security reminders

Because an access code grants account access just like a password:

- Generate codes that are **long and random** — never short or sequential.
- Keep core's **flood-control** limits (`user.flood`) reasonable; the login form
  already rate-limits failed attempts through them.
- Serve the login form over **HTTPS**, and rotate codes as you would passwords.
