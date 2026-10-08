# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12`).
- No dependencies beyond Drupal core, and no third‑party Composer or PHP
  libraries.

If your site runs behind a load balancer or reverse proxy, plan to configure
Drupal's trusted‑proxy settings (`$settings['reverse_proxy']` and
`$settings['reverse_proxy_addresses']` in `settings.php`) — otherwise the module
sees the proxy's IP for every request. See
[Configuration](../configuration/index.md#ip-detection-and-reverse-proxies).

## Install with Composer

From the project root:

```bash
composer require drupal/restrict_by_ip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/restrict_by_ip -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en restrict_by_ip -y
```

There are no submodules. Enabling the module does **not** by itself restrict
anything — every layer starts with an empty (unrestricted) allow‑list. You only
introduce a restriction once you add ranges.

> **Before you add any ranges,** make sure you can recover from a lockout. Confirm
> `drush` works from the server and read the recovery recipe in
> [Configuration](../configuration/index.md#lockout-recovery). A safe first step is
> to add your own IP to the global list *before* narrowing it:
> `drush restrict_by_ip:allow <your-ip>/32`.

## Grant the permission

Assign **Administer restrict by IP** to the roles that should manage these
settings and see the per‑user IP field. It is a restricted‑access permission, so
grant it only to trusted administrators.
