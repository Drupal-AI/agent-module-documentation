# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`) — enabled on every standard Drupal site, and
  pulled in automatically as a dependency.
- An **iContact account** with API access (an App ID / username / password for
  the iContact REST API v2.2). You supply these as credentials during
  configuration.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/icontact_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/icontact_integration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en icontact_integration -y
```

## Verify it worked

Once enabled, open the module's admin dashboard under **Configuration** — if your
API credentials are in place, it should list your live iContact mailing lists and
show the subscription queue status. If the credentials are not set yet, head to
[Configuration](../configuration/index.md) to store them securely first.
