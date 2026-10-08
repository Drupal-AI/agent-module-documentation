# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Purge** module (`purge`) — KeyCDN provides a purger plugin for it and
  enables it as a dependency.
- A **KeyCDN account** with an **API key** and a **zone/region name**.

## Install with Composer

From the project root:

```bash
composer require drupal/keycdn -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Purge module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/keycdn -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en keycdn -y
```

Or enable **KeyCDN** on the **Extend** page (`/admin/modules`). The Purge module is
enabled as a dependency.

Once enabled, KeyCDN immediately starts setting the `Cache-Tag` HTTP header that
KeyCDN needs for tag‑based purging — no configuration required for that part.

## Verify it worked

Go to **Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`). When you add a purger, the KeyCDN
purger should be available in the list. See
[Configuration](../configuration/index.md) to add it and enter your credentials.
