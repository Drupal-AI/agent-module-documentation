# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Link**, **Node**, and **Options** modules — all part of Drupal core.
- The **Redirect** module (`redirect`, ^1) — Short URL creates and synchronizes its
  redirects through it.
- The **`endroid/qr-code`** PHP library (^5 || ^6), used to generate the QR codes.
  Installing the module with Composer pulls this in for you.

Optional add-ons: the **Smart IP** module for country detection, and the separate
**Domain Short URL** module (which itself needs the Domain module) for multi-domain
support.

## Install with Composer

From the project root:

```bash
composer require drupal/shorturl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Redirect and the `endroid/qr-code` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/shorturl -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shorturl -y
```

Drupal enables the core Link, Node, Options, and Redirect dependencies automatically.

## Verify it worked

After enabling, visit **Configuration → Short URL settings**
(`/admin/config/shorturl/settings`) to confirm the settings form loads, then create a
short URL and check that visiting its short link redirects to the destination. See
[Configuration](../configuration/index.md) for the full walkthrough.
