# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Menu UI** module (`menu_ui`).
- The **Organic Groups** module (`og`).

Both dependencies are required and Drupal will enable them automatically. There are
no third‑party Composer libraries or special PHP extensions to install.

> **Pre‑release:** the current release is **2.0.0‑alpha4**. Test it thoroughly
> before relying on it in production, and confirm it lines up with the Organic
> Groups release you're using.

## Install with Composer

From the project root:

```bash
composer require drupal/og_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will pull in Organic Groups if it isn't present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/og_menu -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en og_menu -y
```

This also enables Menu UI and Organic Groups if they aren't already on.

## Verify it worked

Open one of your groups and confirm you can create a menu for it and add links from
the group content form, then place an **OG Menu: single** or **OG Menu: multiple**
block at **Structure → Block layout**. Full usage is in the
[guide overview](../index.md).
