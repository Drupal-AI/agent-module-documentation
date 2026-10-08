# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No third‑party PHP libraries — it uses Drupal's built‑in HTTP client.
- An **[ipdata.co](https://ipdata.co) API key** for geolocation. A shared `test`
  key is used by default but allows only a limited number of lookups, so get your
  own.
- **Outbound HTTPS** access from your server to `api.ipdata.co`.

## Install with Composer

From the project root:

```bash
composer require drupal/ip_lookup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ip_lookup -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ip_lookup -y
```

## Verify it worked

Log in as an administrator, then visit **People → IP Lookup**
(`/admin/people/ip-lookup`). Your own login should appear in the report with
browser and (once a real API key is set) city/region details. First set your
ipdata.co API key and grant the report permission — see
[Configuration](../configuration/index.md).
