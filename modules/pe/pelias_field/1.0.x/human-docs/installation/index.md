# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field**, **Text**, and **System** modules — all part of a standard
  Drupal install.
- Access to a **Pelias** geocoder: either the hosted **Geocode Earth** service
  (which needs an API key) or a **self‑hosted Pelias** instance (which you point the
  module at by URL).

There are no third‑party Composer or PHP library requirements.

> **Heads up:** this project is **not covered by Drupal's security advisory
> policy**. Because the field talks to an external geocoding API with a credential,
> review it accordingly before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/pelias_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pelias_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pelias_field -y
```

## Set the API key as a secret

If you use Geocode Earth, keep the API key out of committed configuration. With
DDEV you can store it in an environment variable:

```bash
ddev dotenv set .ddev/.env --pelias-api-key=<your-ge-key>
ddev restart
```

Never commit `.ddev/.env` or hard‑code the key. Then enter (or reference) the key on
the module's API settings page — see
[Configuring the connection](../index.md#configuring-the-connection).

## Verify it worked

1. Open the module's API settings page, enter the **endpoint** and **API key**, and
   use the built‑in **API test** to confirm the connection works.
2. Add a **Pelias** field to a content type (**Manage fields**).
3. Create content, type an address into the field, and confirm you get live
   autocomplete suggestions and that selecting one stores the geocoded result. If
   suggestions don't appear, re‑check the endpoint, key, and (for paid usage) your
   rate‑limit settings.
