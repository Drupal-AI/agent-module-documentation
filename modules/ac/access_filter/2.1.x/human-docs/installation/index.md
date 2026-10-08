# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules, PHP extensions or third-party Composer libraries are
  required.

If your site runs behind a CDN or reverse proxy/load balancer, configure Drupal's
`reverse_proxy` and `reverse_proxy_addresses` settings in `settings.php` **before**
you rely on any IP rules — otherwise the module cannot see the real client
address. See the [main guide](../index.md) for why this matters.

## Install with Composer

From the project root:

```bash
composer require drupal/access_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/access_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en access_filter -y
```

## Grant the permission

Access Filter adds a **`manage access filters`** permission. Grant it — at
**People → Permissions** (`/admin/people/permissions`) — only to fully trusted
administrative roles, because it controls who may reach the site. Then head to
[Configuration](../configuration/index.md) to create your first rule.
