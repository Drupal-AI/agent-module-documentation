# Installation

## Requirements

- **Drupal 11.4 or newer, including Drupal 12** (`core_version_requirement:
  ^11.4 || ^12`). Drupal 10 and Drupal 11.0–11.3 are not supported by the 3.x
  line — use the 2.x release there instead.
- Core's **Node** module (part of the standard install) — the module adds a
  `private` field to nodes and hooks into node access.
- No other contributed modules and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/private_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/private_content -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en private_content -y
```

## Rebuild node access

Private Content uses Drupal's **node access grants** system, so after enabling it
(and any time you change a content type's privacy mode) you must rebuild node
access permissions so the rules apply to all existing content. Drupal usually
prompts you to do this on the status report; you can also trigger it directly:

```bash
drush php:eval 'node_access_rebuild();'
```

On a large site the rebuild can take a little while, and there is a small ongoing
performance cost from the extra access checks — this is normal for any node-access
module.

There are **no submodules**. Next, head to
[Configuration](../configuration/index.md) to choose each content type's privacy
mode and grant the permissions.
