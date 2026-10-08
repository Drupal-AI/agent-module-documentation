# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`). There
  is no Drupal 11 release of this module yet.
- **Module dependencies**, enabled automatically: **Node** (`node`), **Media**
  (`media`), **Admin Toolbar Tools** (`admin_toolbar_tools`) and **Key** (`key`).
- The **`cloudflare/sdk`** PHP library, installed for you when you require the
  module with Composer.
- A **Cloudflare account**: you'll need the account email plus a Global API Key,
  *or* an API token, and the Zone ID for the site's zone.

## Install with Composer

Install with Composer so all dependencies (including the SDK library) come along:

```bash
composer require drupal/cloudflare_node_cc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudflare_node_cc -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudflare_node_cc -y
```

This also enables the Node, Media, Admin Toolbar Tools and Key modules if they
were not already on.

## Verify it worked

Go to **Configuration → Web services → Cloudflare Node Cache Clear**
(`/admin/config/cloudflare-node-cache-clear`) and confirm the settings form loads.
Purging won't work until you add your Cloudflare credentials and zone — see
[Configuration](../configuration/index.md).
