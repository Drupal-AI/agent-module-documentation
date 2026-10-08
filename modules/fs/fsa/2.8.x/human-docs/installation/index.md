# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A **Fastly** service with an ACL (or two — see Configuration) and an **API token**
  that can modify it.

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

The Composer package is named after the project (`fsa`), so require it with:

```bash
composer require drupal/fsa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fsa -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

The **project** is `fsa` but the **module machine name** is
`fastly_streamline_access`. Enable it by its machine name — `drush en fsa` will
fail:

```bash
drush en fastly_streamline_access -y
```

## Submodules

- **Fastly Streamline Access Admin** (`fastly_streamline_access_admin`) — records
  IP addresses that an admin manually tags for longer-than-average TTLs, into a
  separate "long-lived" ACL. Enable it only if you need that manual tagging:

  ```bash
  drush en fastly_streamline_access_admin -y
  ```

## Verify it worked

Log in as an administrator and open **Configuration → Development → Fastly
Streamline Access** (`/admin/config/development/fastly_streamline_access`). If the
settings form loads, the module is installed. Continue to
[Configuration](../configuration/index.md) to connect it to your Fastly service.
