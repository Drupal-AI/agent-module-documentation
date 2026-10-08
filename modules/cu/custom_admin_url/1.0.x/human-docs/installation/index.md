# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No contrib module dependencies, and no third‑party PHP or JavaScript libraries.
- A meaningful setup needs your site reachable on a **separate back‑office
  host/URL** from the front‑office one, and Drupal's **`trusted_host_patterns`**
  configured in `settings.php` so the host can't be spoofed.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_admin_url -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/custom_admin_url -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_admin_url -y
```

## After installing

Set the back‑office URL right away — until you do, the restriction isn't
configured. Go to **Configuration → System → Custom Admin URL**
(`/admin/config/system/custom-admin-url`) and follow
[Configuration](../configuration/index.md).

## Verify it worked

After configuring the back‑office URL, try reaching an admin page (e.g. `/admin`)
through the **front‑office** host — you should get a **403**. The same page reached
through the **back‑office** host should load normally (subject to your permissions).
