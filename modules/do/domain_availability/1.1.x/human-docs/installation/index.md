# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.3 or newer.**
- **Outbound network access** — the module contacts RDAP and WHOIS servers (and
  the IANA bootstrap) to perform lookups, so the server must be able to reach the
  public internet.
- Module dependencies: core **File** (`file`), **Options** (`options`) and
  **User** (`user`), plus **Saudi ID Validator** (`saudi_id_validator`), which
  supports the optional Saudi domain registration-request workflow.
- No other contributed dependencies.

> **Security advisory coverage:** this project is **not covered** by Drupal's
> security advisory policy. Take that into account before deploying it on a
> sensitive site.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_availability -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the `saudi_id_validator` dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/domain_availability -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_availability -y
```

## Set the permissions

The module gates each route with its own permission. On **People → Permissions**
(`/admin/people/permissions`), grant them according to who should do what:

- **use domain availability api** — call the `/domain-check` JSON endpoint.
- **access domain availability search** — use the `/domain-search` UI (and the
  search block).
- **administer domain availability** — reach the settings form and configure
  providers, cache and rate limits.

## Verify it worked

Go to **Configuration → System → Domain availability** to confirm the settings
form loads, then run a lookup from `/domain-search`. A valid check should return
one of *available*, *registered* or *unknown*. If every lookup comes back as
*unknown*, confirm the server has outbound network access to RDAP/WHOIS.
