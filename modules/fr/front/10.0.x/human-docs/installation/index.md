# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

The module has no other module dependencies and no third‑party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/front -W
```

Note the Composer package is **`drupal/front`**, but the module you enable is named
**`front_page`**. The `-W` (`--with-all-dependencies`) flag lets Composer update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/front -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en front_page -y
```

## Grant the permission

Front Page provides an **Administer front page** permission. Grant it at **People →
Permissions** (`/admin/people/permissions`) to trusted administrator roles only,
since it controls where every role lands on the site.

## Verify it worked

Go to **Configuration → System → Front page** (`/admin/config/system/front-page`).
You should see the per‑role front‑page configuration screen, ready for you to set up
front pages as described in [Configuration](../configuration/index.md).

> **This branch (10.0.x) is a beta and a partial port** of the older Drupal 7
> feature set. The **Redirect** method is fully ported; **Themed** and **Full** are
> the other supported methods. The **Alias** method from the 2.x/Drupal 7 branch is
> not part of this release. If you hit a bug, the maintainers welcome issues.
