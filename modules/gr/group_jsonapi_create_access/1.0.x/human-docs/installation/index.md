# Installation

## Requirements

Group JSON:API Create Access needs the Group module and core JSON:API:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Group** module (`group`).
- Core's **JSON:API** module (`jsonapi`).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/group_jsonapi_create_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_jsonapi_create_access -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_jsonapi_create_access -y
```

Core JSON:API and the Group module are enabled as dependencies if they are not
already on. There is nothing to configure afterwards.

## Submodules

This module ships no submodules.

## Verify it worked

From a JSON:API client, POST a `group_relationship` entity with a `gid`
relationship referencing a group you have create access to. Before installing the
module the request would fail with an access error even for a permitted user;
after installing it, the request should succeed (and requests without a valid
group in the body should still be denied).
