# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Drupal core's **Node**, **Token**, **Editor**, and **CKEditor** modules —
  enabled automatically as dependencies. (Token ships as a contributed module on
  some sites; Composer will resolve it.)

## Install with Composer

From the project root:

```bash
composer require drupal/email_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_manager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_manager -y
```

## Grant the permission

Give trusted administrators the **Administer email templates** permission at
**People → Permissions** (`/admin/people/permissions`). This restricted
permission gates every Email Manager route — treat it carefully, since templates
are HTML rendered directly into outbound email.

## Verify it worked

Go to **Configuration → System → Email Manager**
(`/admin/config/system/email-manager`). The template list should load, with links
to manage templates and keys. Continue to [Configuration](../configuration/index.md)
to wire it up.
