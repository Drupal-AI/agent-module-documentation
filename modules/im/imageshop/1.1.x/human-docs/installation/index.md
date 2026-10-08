# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- An **Imageshop account** with API credentials: a permanent **token** and a
  **private key**, obtained from Imageshop.
- **Outbound network access** from the server to Imageshop's web services
  (`webservices.imageshop.no`) and to the iframe host (`client.imageshop.no`), so
  the token exchange and the image browser can work.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/imageshop -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imageshop -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imageshop -y
```

## Verify it worked

Once enabled, go to **Configuration → Media → Imageshop**
(`/admin/config/media/imageshop`) to enter your credentials. If the settings page
does not open even as an administrator, see the permission-mismatch note in the
[overview](../index.md) and [Configuration](../configuration/index.md).

The next step is entirely about configuration — entering your Imageshop
credentials, granting the `access imageshop` permission to editors, and choosing
which media types use the Imageshop browser. See
[Configuration](../configuration/index.md).
