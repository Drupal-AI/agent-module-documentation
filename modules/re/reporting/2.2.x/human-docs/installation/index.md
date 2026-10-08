# Installation

## Requirements

- **Drupal 10.1, 11 or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The **`gapple/structured-fields`** PHP library (`^2.0`), used to build the
  `Reporting-Endpoints` header in the correct structured-fields format. Composer
  installs it automatically.
- Recommended: core **Database Logging** (`dblog`) enabled, so you get the
  **Recent violation reports** admin page. Without it, reports still go to whatever
  logger backend you have configured (the `reporting` channel), just not that table.

Reporting has no dependencies on other contrib modules. The **Content-Security-
Policy** (`csp`) module is only an optional integration — install it if you want
CSP to send violations to a reporting endpoint.

## Install with Composer

From the project root:

```bash
composer require drupal/reporting -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`gapple/structured-fields` and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reporting -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reporting -y
```

Enabling it creates one ready-to-use endpoint called `default`. If you want the
in-admin reports table, make sure core dblog is on too:

```bash
drush en dblog -y
```

If you are upgrading from a pre-2.2 release, run database updates so existing
endpoints pick up the new `type`/`external_uri` fields (they are backfilled to
`internal`):

```bash
drush updatedb -y
```

## Verify it worked

Go to **Configuration → System → Reporting endpoints**
(`/admin/config/system/reporting`) — you should see the `default` endpoint listed.
Load any page and inspect the response headers; you should see a
`Reporting-Endpoints:` header advertising your enabled endpoint(s). Then head to
[Configuration](../configuration/index.md) to add endpoints and wire up CSP.
