# Installation

## Requirements

- **Drupal 8.8, 9.3, 10, or 11** (`core_version_requirement: ^8.8 || ^9.3 || ^10 || ^11`).
- No other Drupal modules or PHP libraries are required.
- Several features (registration, API-key retrieval, the auth challenge, and the
  "contact us" support form) make **outbound calls to miniOrange's backend**
  (`xecurify.com`). The brute-force protection itself does not depend on the vendor
  backend.

## Install with Composer

From the project root:

```bash
composer require drupal/security_login_secure -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/security_login_secure -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en security_login_secure -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Verify it worked

After enabling, open the module's admin section (see
[Configuration](../configuration/index.md)), set a low failed-login threshold, and
confirm that repeated bad logins block the account/IP as configured.
