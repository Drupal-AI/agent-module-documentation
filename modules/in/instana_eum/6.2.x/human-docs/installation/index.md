# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- An **Instana account** with a website/mobile application configured, so you have
  a reporting URL and a beacon key to enter.
- Your visitors' browsers must be able to load `https://eum.instana.io/eum.min.js`
  (the beacon agent is fetched from Instana on every page).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/instana_eum -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/instana_eum -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en instana_eum -y
```

## Verify it worked

Go to **Configuration → System → Instana EUM Configuration**
(`/admin/config/services/instana_eum`). If the settings form opens, the module is
installed. Nothing is reported to Instana yet — the beacon only injects once you
enter a key and the "enabled" box is ticked, which is covered in
[Configuration](../configuration/index.md).
