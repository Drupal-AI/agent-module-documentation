# Installation

## Requirements

Site Guardian needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Update Manager** module (`update`) — it powers the enabled-projects and
  update-status endpoint. Drupal enables it automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/site_guardian -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_guardian -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_guardian -y
```

On enable, the module:

- Generates a **strong random access key** and stores it in configuration.
- Sets the module to **activated**, so the endpoints are live immediately.

> **Important:** if you uninstall and later re-enable the module, a **brand-new
> key** is generated — any monitoring tools using the old key must be updated.

## After enabling

1. Serve the site over **HTTPS** — the key travels in the URL query string and
   must not be exposed over plain HTTP.
2. Open **Configuration → Development → Site Guardian** to copy the key and review
   the settings — see [Configuration](../configuration/index.md).
3. Consider keeping the key out of exported configuration by overriding it in
   `settings.php`:

   ```php
   $config['site_guardian.settings']['site_guardian_key'] = getenv('SITE_GUARDIAN_KEY');
   ```

   Store the value in an environment variable rather than hard-coding it, or use
   Config Ignore.
