# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Key](https://www.drupal.org/project/key)** module (`key`) — a hard
  dependency, installed automatically with Composer. It's what lets the Azure
  client secret be stored securely (env-backed) rather than in configuration.
- The **Microsoft Graph SDK for PHP**, pulled in via Composer when you install
  this module — which is why Composer installation (below) is the recommended
  route.
- On the Microsoft side: an **Azure / Microsoft Entra ID app registration** with
  the appropriate Graph API permissions (covered in
  [Configuration](../configuration/index.md)).

## Install with Composer

Install via Composer so the required version of the Graph PHP SDK is pulled in:

```bash
composer require drupal/ms_graph_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Key module and the Graph SDK as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ms_graph_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. If you don't
> already have the Key module, `ddev composer require drupal/key` and
> `ddev drush en key -y`.

## Enable the module

```bash
drush en ms_graph_api -y
```

This also ensures the Key module is enabled (it's a dependency). No user-facing
functionality appears — the module just makes the Graph client services available
once you've registered an app and created the Key(s). See
[Configuration](../configuration/index.md).

## Verify it worked

Confirm the module (and Key) are enabled:

```bash
drush pm:list --status=enabled | grep -E 'ms_graph_api|^.* key '
```

Full verification is really "can a consuming module obtain an authenticated
client?" — complete the [Configuration](../configuration/index.md) steps, then
have your code call the `ms_graph_api.graph` service and make a simple Graph
request (for example `GET /me`).
