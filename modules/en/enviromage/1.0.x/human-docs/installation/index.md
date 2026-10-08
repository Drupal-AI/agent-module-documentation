# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- **[Automatic Updates](https://www.drupal.org/project/automatic_updates)**
  (`automatic_updates`) — a required dependency.
- A working **Composer** setup on the server, since the dry‑run check runs
  `composer update` from the project directory.

Note this project is **not** covered by the security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/enviromage -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Automatic Updates and updates
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/enviromage -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en enviromage -y
```

Drush enables the Automatic Updates dependency at the same time if it is not
already on.

## Grant the permission narrowly

Enviromage's dashboard — including the Composer command runner — is gated by the
**Administer env settings** permission (marked *restrict access*). Grant it only
to trusted operators under **People → Permissions**.

## Verify it worked

Go to **Configuration → Development → Enviromage**
(`/admin/config/development/enviromage`). You should see the dashboard with its
settings form, Composer check, module sizes, environment read, and log. See
[Configuration](../configuration/index.md) for how each part works.
