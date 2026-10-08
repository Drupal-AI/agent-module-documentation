# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Media** module (`media`) and **CKEditor 5** module (`ckeditor5`) — both
  ship with Drupal core and are enabled automatically as dependencies.
- A **Mediaflow account** and a Mediaflow **API app** providing an OAuth2 **client
  id**, **client secret**, and a long‑lived **refresh token**. For version 2.x you
  must obtain these yourself — contact support@mediaflow.com to acquire a set of API
  keys.

There are no additional Composer or PHP library requirements. Note the module is
**not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/mediaflow -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mediaflow -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mediaflow -y
```

Media and CKEditor 5 are enabled automatically as dependencies if they are not
already on.

## Grant permissions

At **People → Permissions** (`/admin/people/permissions`):

- **`administer mediaflow`** — grant only to trusted administrators. This permission
  controls the credentials form and the asset‑import route.
- **`use mediaflow`** — grant to the editor roles that should browse and insert
  Mediaflow assets.

## Verify it worked

Go to **Configuration → Media → Mediaflow** (`/admin/config/media/mediaflow`). If
the settings form loads, the module is installed — now enter your API credentials as
described in [Configuration](../configuration/index.md). The integration is only
functional once valid credentials are saved.
