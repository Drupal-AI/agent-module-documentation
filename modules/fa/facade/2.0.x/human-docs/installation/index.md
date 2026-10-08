# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Cloud** module (`drupal/cloud`) — Façade depends on it, and Cloud powers
  the reference OpenStack/AWS provider. Composer pulls it in automatically with
  the command below.

There are no additional PHP library requirements declared, but the reference
provider expects working credentials for whatever cloud platform you deploy to.

## Install with Composer

From the project root:

```bash
composer require drupal/facade -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Cloud module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facade -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facade -y
```

## Submodules

Façade ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Façade Remote Worker** | `facade_remote_worker` | A REST resource that exposes tenant/cloud configuration, a Drush entity command, a per‑user **bearer token** field, and a global bearer‑token authentication provider — so remote worker machines can authenticate back to the control site and fetch the configuration they need. |

Enable it only if you run remote workers:

```bash
drush en facade_remote_worker -y
```

Each bearer token is a credential. Issue one per worker user, keep it out of
version control and logs, and rotate it if it may have leaked.

## Verify it worked

Log in as an administrator and go to **Configuration → Web services → Façade**
(`/admin/config/services/facade`). If the settings form loads, the module is
installed. Next, review the **Tenant** permissions on the People → Permissions
page and define at least one Tenant type before you start creating tenants —
[Configuration](../configuration/index.md) walks through this.
