# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Three PHP libraries, which Composer installs for you with the module:
  - `saintsystems/odata-client: ^0.2.4`
  - `league/oauth2-client: ^2.4`
  - `thenetworg/oauth2-azure: ^1.4` (used for authenticating against
    Azure‑protected OData endpoints such as Microsoft Dynamics CRM)
- Access to an **OData server** — its endpoint URL, the collection(s) you want to
  work with, and credentials for whatever authentication it requires.

## Install with Composer

From the project root:

```bash
composer require drupal/odata_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the OData and OAuth
client libraries above and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/odata_client -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

> **Note:** This release is an alpha (`3.1.0-alpha2`). Review it before relying on
> it in production, and keep it updated.

## Enable the module

```bash
drush en odata_client -y
```

## Verify it worked

Log in as an administrator and go to **Structure → OData server**
(`/admin/structure/odata_server`). If the server‑configuration listing loads, the
module is active. Create a server configuration there (see
[Configuration](../configuration/index.md)), then confirm connectivity from code —
for example a quick `\Drupal::service('odata_client.io')->connect('default');`
followed by a `count()` against a known collection.
