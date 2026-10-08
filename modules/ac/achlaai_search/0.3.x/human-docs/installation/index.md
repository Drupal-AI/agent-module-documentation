# Installation

## Requirements

- **Drupal 10.3 or 11.3** (`core_version_requirement: ^10.3 || ^11.3`).
- **PHP 8.1+**, with the JSON, OpenSSL and Sodium extensions (used for the
  signature and PKCE verification in the ownership flow).
- A **public, HTTPS site origin** for production trust — the ownership check needs
  your site to be reachable, and production trust anchors expect HTTPS.
- An account with the hosted **Achla AI Search** service (the SaaS side handles
  indexing, answers and billing).

## Install with Composer

From the project root:

```bash
composer require drupal/achlaai_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/achlaai_search -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

### Migrating from the legacy package

If your site used the older `achlaai/achlaai-search` beta package, switch to the
`drupal/` package:

```bash
composer remove achlaai/achlaai-search --no-update
composer require drupal/achlaai_search --with-all-dependencies
```

The upgrade disables the previous connector, so an administrator must reconnect (see
[Configuration](../configuration/index.md)) before widget output resumes.

## Enable the module

```bash
drush en achlaai_search -y
```

## Grant the connector permission

At **People → Permissions** (`/admin/people/permissions`), grant **Manage the Achla
AI Search connector** (`manage achlaai_search connector`) only to trusted operators.
It is a restricted permission and it gates every admin and AJAX route in the module.
Then continue to [Configuration](../configuration/index.md).
