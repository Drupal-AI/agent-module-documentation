# Installation

## Requirements

Storage Entities is self-contained:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No third-party Composer libraries and no other contrib module dependencies.

The **Token** module is a nice-to-have but not required: it only adds the
token-browser link on the storage-type form. Name patterns still work without it.

## Install with Composer

From the project root:

```bash
composer require drupal/storage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/storage -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en storage -y
```

Once enabled, you'll find **Storage types** under *Structure* and the
**Storage** overview under *Content*. Nothing is configured yet — your next step
is to create a storage type (see [Configuration](../configuration/index.md)).

## Optional submodule — Rabbit Hole behavior

Storage ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Rabbit Hole for Storage** | `rh_storage` | Adds [Rabbit Hole](https://www.drupal.org/project/rabbit_hole) behavior to storage entities, so you can control what happens when someone reaches a storage item's URL (e.g. access denied, page not found, or a redirect). Requires the Rabbit Hole module. |

Enable it only if you need that control:

```bash
drush en rh_storage -y
```
