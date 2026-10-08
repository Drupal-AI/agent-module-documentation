# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

No Request New Password has **no module dependencies** and no third-party Composer
or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/noreqnewpass -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/noreqnewpass -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en noreqnewpass -y
```

The module ships **no submodules**. Note that enabling it does **not** change
anything yet — the module is inert until you tick its checkbox (see
[Configuration](../configuration/index.md)).

## Set permissions

Grant the **Administer noreqnewpass** permission at **People → Permissions** to the
roles that should be able to toggle the setting (typically administrators).

## Verify it worked

Log in as an administrator and go to **Configuration → People → No Request New
Password** (`/admin/config/people/noreqnewpass`). You should see a single checkbox,
"Disable Request new password link." Tick it and save, then confirm the "Request
new password" link is gone from the login block and that `/user/password` is no
longer accessible.
