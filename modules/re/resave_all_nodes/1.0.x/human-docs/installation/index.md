# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Node** module (enabled on any standard content site, and pulled in as a
  dependency).

There are no third‑party Composer or PHP library requirements.

> **This is a beta release.** The module reports a `8.x-1.0-beta2` version, and it
> is not covered by Drupal's security advisory policy. Because a resave is a
> wide-reaching operation, test it on a copy of your site before running it against
> production content.

## Install with Composer

From the project root:

```bash
composer require drupal/resave_all_nodes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/resave_all_nodes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en resave_all_nodes -y
```

Then grant the **Resave all nodes** permission to trusted administrators at
**People → Permissions** — it is a restricted permission, so it is not granted to
anyone by default.

## Verify it worked

Go to **Configuration → Development → Resave all nodes**
(`/admin/config/development/resave-all-nodes`). The batch form with its content-type
selector should load. See the "How to use it" section of the [overview](../index.md)
for how to run it safely.
