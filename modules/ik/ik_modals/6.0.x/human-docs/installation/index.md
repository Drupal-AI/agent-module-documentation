# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- Core's **Block** module.
- The contributed **Address** module (`drupal/address`).
- Composer installation is required — do not install this module by hand.

For location-aware targeting the module bundles the **GeoIP2 PHP library** and can
optionally use the **ipdata** or **AbstractAPI** geolocation services. Those two are
optional and each needs an API key (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/ik_modals -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Address module
and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ik_modals -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ik_modals -y
```

This also enables its dependencies (Block and Address) if they are not already on.
Then clear the cache:

```bash
drush cr
```

## Verify it worked

Log in as an administrator and confirm the module appears as enabled under
**Extend** (`/admin/modules`). Then open its settings form via the configure link
(`ik_modals.settings`) and check that you can create a Modal — see
[Configuration](../configuration/index.md) for the full walkthrough.
