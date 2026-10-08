# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A **Constant Contact account** and an **application** registered in the Constant
  Contact developer portal, so you have an API key (client ID) and secret to authorize
  with.

The module has no mandatory Drupal module dependencies, but several core/contrib
modules unlock optional features:

| Module | Needed for |
|--------|------------|
| `block` (core) | Placing the per-list and multi-list signup blocks. |
| `rest` (core) | The optional signup REST endpoint. |
| `webform` (contrib) | The bundled Constant Contact webform handler. |
| `datetime` (core) | Birthday/anniversary and other date custom fields. |

Enable whichever of these you plan to use.

## Install with Composer

From the project root:

```bash
composer require drupal/ik_constant_contact -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ik_constant_contact -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ik_constant_contact -y
```

There are no submodules. After enabling, continue to
[Configuration](../configuration/index.md) to enter your API credentials and authorize
your Constant Contact account — nothing works until the account is connected.
