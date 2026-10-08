# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **JSON:API** module (`jsonapi`) enabled — this is the only dependency,
  and Drupal enables it automatically when you turn on JSON:API Role Access.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_role_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jsonapi_role_access -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_role_access -y
```

This also enables core JSON:API if it isn't already on. Importantly, the module
installs with a working default — **Allow mode with the *authenticated* role
selected** — so as soon as it's enabled, anonymous visitors are blocked from
JSON:API and logged‑in users are allowed. Review the
[Configuration](../configuration/index.md) to adjust that to your needs.

## Submodules

JSON:API Role Access ships no submodules.
