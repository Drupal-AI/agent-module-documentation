# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **User** module (`user`), which is part of a standard Drupal install.

There are no third-party Composer or PHP library requirements.

> **Behind a proxy or CDN?** Before relying on this module, make sure Drupal is
> configured to see the real client IP (trusted proxies and `X-Forwarded-For`
> handling in `settings.php`). The module blocks by client IP, so if all traffic
> appears to come from your proxy you could block the proxy itself — or let an
> attacker evade the block by rotating IPs. This is a prerequisite, not an
> optional extra.

## Install with Composer

From the project root:

```bash
composer require drupal/ddos_security -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ddos_security -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ddos_security -y
```

## Verify it worked

Log in as a user with the **Administer site configuration** permission and visit
**`/admin/config/ddos-security`**. You should see the module's settings and the
blocked-IP management screen. Set your threshold and block behaviour on the
[Configuration](../configuration/index.md) page before depending on it in
production.
