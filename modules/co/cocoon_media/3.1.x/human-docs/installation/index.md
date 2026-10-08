# Installation

## Requirements

- **Drupal 8, 9.3+, or 10** (`core_version_requirement: ^8 || ^9.3 || ^10`).
- Core's **Media** (`media`) module (8.4 or newer) — enabled as a dependency.
- The PHP **SOAP extension** enabled on your server — the module talks to Cocoon
  over SOAP and will not function without it.
- A valid **Cocoon subscription** and account credentials (subdomain, username,
  API secret key).

## Install with Composer

From the project root:

```bash
composer require drupal/cocoon_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Media
dependency and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cocoon_media -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. DDEV's web
> container includes the PHP SOAP extension.

## Enable the module

```bash
drush en cocoon_media -y
```

## Verify it worked

Log in as an administrator and open **Configuration → Media → Cocoon Media**
(`/admin/config/media/cocoon_media_settings`). If the settings form loads, the
module is installed. It will not connect to Cocoon until you enter your account
credentials — see [Configuration](../configuration/index.md). If SOAP is missing
or the credentials are wrong, the module logs errors and surfaces them to
administrators.
