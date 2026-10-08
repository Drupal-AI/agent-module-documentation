# Installation

## Requirements

- **Drupal 9.4 or 10** (`core_version_requirement: ^9.4 || ^10`).
- The **Webform** module (`webform`) — required; the integration works through a
  Webform handler.
- An **Omnisend account** with an **API key** (and public key) from your Omnisend
  dashboard.

There are no bundled third‑party Composer libraries beyond what Webform brings.

## Install with Composer

From the project root:

```bash
composer require drupal/omnisend -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Webform if it isn't present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/omnisend -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en omnisend -y
```

This also enables Webform if it isn't already on.

## Verify it worked

Go to **Configuration → Web services → Omnisend**
(`/admin/config/services/omnisend`) and confirm the settings form loads. After you've
entered your API key (see [Configuration](../configuration/index.md)), the admin
dashboard at `/admin/omnisend/campaigns` should be able to list your Omnisend
campaigns.
