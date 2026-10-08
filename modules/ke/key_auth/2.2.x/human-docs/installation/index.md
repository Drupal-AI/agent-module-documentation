# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **User** module (always enabled on a standard site) — the only dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/key_auth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/key_auth -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en key_auth -y
```

Enabling the module adds an `api_key` field to every user account and registers the
key-authentication provider. There are no submodules.

> **Note:** This module is called *Key Authentication*, which is unrelated to the
> separate **Key** module (`drupal/key`) used for storing secrets. You do not need
> the Key module for this one.

## Grant the permission

A key does nothing until the owning user's role has the **Use key authentication**
permission. Assign it at **People → Permissions**
(`/admin/people/permissions`) — typically to a dedicated "API" or "service account"
role:

```bash
drush role:perm:add api_consumer 'use key authentication'
```

See [Configuration](../configuration/index.md) for why this permission gates both
authentication *and* whether a user is given a key at all.

## Verify it worked

Visit **Configuration → Web services → Key authentication**
(`/admin/config/services/key-auth`) as an administrator to confirm the settings form
loads, then open any user's **Key authentication** tab (`/user/{id}/key-auth`) to
generate a key.
