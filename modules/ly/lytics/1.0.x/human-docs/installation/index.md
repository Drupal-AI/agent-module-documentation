# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- A **Lytics account** with an Access Token (found in your Lytics account
  settings).
- Outbound network access from the site to the Lytics API (`api.lytics.io`) and
  to the Lytics tag/CDN hosts.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/lytics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lytics -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lytics -y
```

## Permissions

Lytics provides granular permissions — among them **manage lytics connection**,
**view lytics connection**, **view lytics dashboard**, **manage lytics widgets**,
and **manage lytics recommendations**. Grant them at **People → Permissions**
(`/admin/people/permissions`). Be conservative with **manage lytics connection**:
that screen exposes the Access Token, so limit it to trusted administrators.

## Verify it worked

Go to **Configuration → System → Lytics** (`/admin/config/system/lytics`). If the
settings form loads, the module is installed. Entering a valid Access Token and
saving — after which the module fills in your account name, id, and domain — is
the real confirmation that everything is wired up. See
[Configuration](../configuration/index.md).
