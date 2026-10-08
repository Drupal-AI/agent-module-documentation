# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Assignments** module (`assignments`) — the entity this module extends.
- The **OAuth2 Client** module (`oauth2_client`) — used to authenticate with
  Hootsuite over OAuth2.
- A **Hootsuite account** with API access, so you can register an app and obtain
  its OAuth2 client credentials.

Both module dependencies are pulled in by Composer with the `-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/assignments_hootsuite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `assignments` and
`oauth2_client` and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/assignments_hootsuite -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en assignments_hootsuite -y
```

Drush enables the required `assignments` and `oauth2_client` dependencies at the
same time. After enabling, register a Hootsuite app and enter its credentials —
see [Configuration](../configuration/index.md).

This module has no submodules.
