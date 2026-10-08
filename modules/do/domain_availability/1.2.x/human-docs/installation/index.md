# Installation

## Requirements

- **Drupal 10.3, 11 or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **PHP 8.3 or newer.**
- The **`json`, `mbstring` and `sockets`** PHP extensions.
- **Outbound network access** — the module contacts RDAP and WHOIS servers (and
  the IANA bootstrap) to perform lookups, so the server must be able to reach the
  public internet. WHOIS-only TLDs also need **outbound TCP port 43** open.
- Module dependencies: core **File** (`file`), **Options** (`options`) and
  **User** (`user`), plus **Saudi ID Validator** (`saudi_id_validator`), which
  backs the optional Saudi domain registration-request workflow. Drupal installs
  it automatically as a declared dependency.

> **Security advisory coverage:** this project is **not covered** by Drupal's
> security advisory policy. Take that into account before deploying it on a
> sensitive site.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_availability
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/domain_availability`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_availability -y
```

`saudi_id_validator` is enabled automatically as a dependency; there is no manual
step.

## Set the permissions

The module gates each route with its own permission. On **People → Permissions**
(`/admin/people/permissions`), grant them according to who should do what:

- **use domain availability api** — call the `/domain-check` JSON endpoint. Each
  lookup fans out to roughly twenty registries, so grant this only to trusted
  roles.
- **access domain availability search** — use the `/domain-search` UI (and the
  search block).
- **administer domain availability** — reach the settings form and configure
  providers, cache and rate limits.
- **view / manage / delete domain registration requests** — for the optional
  registration workflow. These records hold personal data, so grant them
  carefully.

## Verify it worked

Go to **Configuration → System → Domain availability** to confirm the settings
form loads, then run a lookup from `/domain-search`. A valid check should return
one of *available*, *registered* or *unknown*. If every lookup comes back as
*unknown*, confirm the server has outbound network access — check
**Reports → Status report** for the *WHOIS egress* entry, which tells you whether
outbound port 43 is reachable.

## Upgrading from 1.1.x

Run `composer require drupal/domain_availability` and clear caches
(`drush cr`). Release 1.2.0 introduces no new database updates and no
configuration or API changes.
