# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** (`media`) and **Media Library** (`media_library`) modules —
  these are the module's only dependencies, and Drupal enables them automatically
  when you turn on Media Power BI.
- A Microsoft Power BI report with a share/embed URL to paste in.

There are no third‑party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/media_power_bi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_power_bi -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_power_bi -y
```

Enabling Media Power BI also enables core Media and Media Library if they aren't
already on. There is no settings page to configure. Your next step is to create a
media type that uses the **Media Power BI** source — see the
[overview](../index.md#how-to-use-it) for the walkthrough.
