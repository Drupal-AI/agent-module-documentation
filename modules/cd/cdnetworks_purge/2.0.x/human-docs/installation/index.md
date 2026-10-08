# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- [Purge](https://www.drupal.org/project/purge) (`purge`) — the cache
  invalidation framework this module plugs into.
- [Key](https://www.drupal.org/project/key) (`key`) — used to store your
  CDNetworks API credentials securely.
- A **CDNetworks account and API key** with access to one or more Content
  Management CDN services. (CDNetworks' API documentation is not publicly
  available.)

There are no third-party Composer or PHP library requirements beyond the modules
above.

## Install with Composer

From the project root:

```bash
composer require drupal/cdnetworks_purge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will pull in Purge and Key.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cdnetworks_purge -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cdnetworks_purge -y
```

Drupal enables Purge and Key at the same time as dependencies.

## Verify it worked

Confirm all three modules (CDNetworks Purge, Purge, Key) are enabled under
**Extend** (`/admin/modules`). The module isn't functional until you store your
credentials and wire the purger into Purge — head to
[Configuration](../configuration/index.md) next.
