# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **IMCE** module (`imce`) — this module extends it, so IMCE must be installed
  with at least one profile.
- A **custom module** in which to write your `ImceDfp` plugin(s) — the dynamic
  path logic lives in code you supply (see the [overview](../index.md)).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/imce_dfp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including IMCE if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imce_dfp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imce_dfp -y
```

This also enables IMCE if it is not already on.

## Verify it worked

The module adds no visible screen of its own. Confirm the install by writing a
simple `ImceDfp` plugin in a custom module, referencing it in an IMCE profile's
folder path as `dfp_plugin: <your_plugin_id>`, and checking that IMCE browses the
folder your plugin returns. See "How to set it up" in the
[overview](../index.md).
