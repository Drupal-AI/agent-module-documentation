# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Interface Translation** module (`locale`) — Drupal enables it
  automatically as a dependency when you turn on Locale delete.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/locale_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/locale_delete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en locale_delete -y
```

## Grant the permission

Deleting translation strings is destructive, so it is behind its own permission.
Go to **People → Permissions** (`/admin/people/permissions`), find **Use locale
delete**, and tick it only for roles you trust with translation administration
(typically an administrator or a dedicated translator role). Save permissions.

## Verify it worked

As a user with the **Use locale delete** permission, visit a string's delete
route — `/admin/config/regional/translate/delete/{lid}`, substituting a real
locale ID for `{lid}`. You should see a confirmation page showing the source
text. Confirming deletes the string and its translations and returns you to the
Translate interface page with a status message.
