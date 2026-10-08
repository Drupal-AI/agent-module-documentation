# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`), which is always present on a Drupal site.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dpxu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dpxu -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dpxu -y
```

Enabling the module registers the two roles (`dpxu_manager` and `dpxu_managed`)
and the `field_dpxu_manager_uid` reference field that links a managed account to
its manager.

## Verify it worked

1. Go to **People → Roles** (`/admin/people/roles`) and confirm the
   **`dpxu_manager`** and **`dpxu_managed`** roles now exist.
2. Go to **Configuration → System → Designated Proxy User**
   (`/admin/config/system/dpxu`) and confirm the settings form loads.
3. Assign the `dpxu_manager` role and the create/edit permissions to a trusted
   user, then visit `/user/add/managed-user` as that user to confirm the
   managed‑account creation form appears.

Next, head to [Configuration](../configuration/index.md) to set the creation
cap, email handling, and message templates before you start creating accounts.
