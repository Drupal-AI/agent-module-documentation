# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **Purge** module (`purge` `^3.4`), and its **core‑tags queuer**
  (`purge_queuer_coretags`) — both declared as dependencies and enabled
  automatically.
- A site actually hosted on **Acquia Cloud** (or Acquia Site Factory). Acquia Purge
  auto‑detects the environment; off‑Acquia it has nothing to talk to.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_purge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Purge module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_purge -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the modules

Enable Acquia Purge together with the Purge components that make it useful — a
queuer, processors, and (optionally) Purge's Drush and UI helpers:

```bash
drush en acquia_purge --yes
drush en purge_drush purge_queuer_coretags purge_processor_lateruntime purge_processor_cron purge_ui --yes
```

`acquia_purge` already declares `purge` and `purge_queuer_coretags` as
dependencies, so those come in automatically; the extra Purge components above add
the queuing, processing, Drush commands, and admin UI you will want.

## Register the purgers

Acquia Purge has no settings form — you register its purger plugins with Purge on
the command line:

```bash
# Acquia Cloud Varnish load balancers:
drush p:purger-add --if-not-exists acquia_purge

# (optional) Acquia Platform CDN:
drush p:purger-add --if-not-exists acquia_platform_cdn
```

Then confirm everything is healthy:

```bash
drush p:diagnostics --fields=title,severity
```

## Optional submodule — GeoIP

Acquia Purge ships one submodule, **`acquia_purge_geoip`**, which adds
`X-Geo-Country` to the `Vary` header so pages can be cached per visitor country:

```bash
drush en acquia_purge_geoip -y
```

Enable it only if you serve content that varies by country.

For the full setup walkthrough and the `settings.php` tuning keys, see the
[overview](../index.md#how-to-use-it).
