# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

> **Heads up:** this release is marked *not covered* by Drupal's security advisory
> policy, and the module is a soft redirect gate rather than a security boundary —
> see the [overview](../index.md) for what that means. Don't use it to protect
> genuinely sensitive content.

## Install with Composer

From the project root:

```bash
composer require drupal/comingsoon_mode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/comingsoon_mode -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en comingsoon_mode -y
```

Enabling the module does **not** immediately gate your site — the mode starts
switched off. You turn it on and design the landing page from the settings form.

## Verify it worked

Go to **Configuration → System → Coming Soon Mode**
(`/admin/config/system/comingsoon_mode`). If the settings form loads, the module
is installed. From there, follow [Configuration](../configuration/index.md) to
activate the mode and build your landing page. Before you enable it on a live
site, confirm the `access website in comingsoon mode` permission is granted to the
roles that should keep seeing the real site (**People → Permissions**), so you
don't lock yourself out.
