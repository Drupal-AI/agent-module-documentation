# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third‑party Composer or PHP library requirements, and no other modules are
  required.

> **A note on branches:** the 1.x branch supports Drupal 11 but will not be
> updated for Drupal 12. If you are starting fresh, the maintainer recommends the
> 2.0.x branch for the future; use the branch that matches your site's needs.

## Install with Composer

From the project root:

```bash
composer require drupal/restrict_route_by_ip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/restrict_route_by_ip -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en restrict_route_by_ip -y
```

## Verify it worked

Log in as a user with the **Administer restrict route by IP** permission and go to
**Configuration → System → Restrict route by IP**
(`/admin/config/system/restrict_route_by_ip`). You should see the (initially
empty) list of route restrictions and an **Add** action. From here, continue to
[Configuration](../configuration/index.md) to create your first rule — and read
the lockout caution there before you do.
