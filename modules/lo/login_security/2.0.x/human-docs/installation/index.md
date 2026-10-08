# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 ||
  ^11`).
- For **hard IP banning**, either core's **Ban** module (`ban`) or the contrib
  **AdvBan** module (`advban`) must be enabled. Login Security delegates hard bans
  to whichever is installed; if neither is present, the module's status report
  raises a warning and hard bans won't work (the other protections still do).

There are no third‑party Composer or PHP library requirements, and Login Security
has **no other module dependencies**.

## Install with Composer

From the project root:

```bash
composer require drupal/login_security -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/login_security -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_security -y
```

If you want the hard IP‑ban feature, enable Ban (which ships with core) as well:

```bash
drush en ban -y
```

Login Security ships **no submodules** and defines no permissions of its own — the
settings form uses core's **Administer site configuration** permission.

## Verify it worked

Go to **Configuration → People → Login Security**
(`/admin/config/people/login_security`) and confirm the settings form loads. If
you plan to use hard IP bans, check the site status report
(`/admin/reports/status`) to make sure it isn't warning that Ban/AdvBan is
missing. Then see [Configuration](../configuration/index.md) to set your
thresholds.
