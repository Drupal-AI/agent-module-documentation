# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No hard module dependencies and no PHP library requirements.
- **An external authentication module to do the actual login.** Hybrid Login was
  built around the **SAML Authentication** module but is configurable to work
  with other SAML modules. Install and configure that separately — Hybrid Login
  only renders the entry point.

## Install with Composer

From the project root:

```bash
composer require drupal/hybrid_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hybrid_login -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hybrid_login -y
```

## Place the block

After enabling, place the block so it appears on the login page:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find **Hybrid Login** (in the *Forms* category) and place it — the recommended
   region is **Content**, above the main page content and below the admin tabs.
3. In the block's visibility settings, restrict it to show only on **`/user/login`**.
4. Save the block.

## Verify it worked

Log out and visit `/user/login`. You should see the Hybrid Login block with your
external‑login button. Once you've configured the settings (see
[Configuration](../configuration/index.md)) and pointed the button at your SAML
login path, clicking it should hand off to your external auth module. Remember to
clear the cache after changing settings.
