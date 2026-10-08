# Installation

## Requirements

EU Cookie Compliance GTM is a glue module — it needs both sides of the bridge
already in place:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 5.4 or newer** (`php: >=5.4`).
- **EU Cookie Compliance** (`drupal/eu_cookie_compliance` `^1.24`) — the GDPR
  cookie‑consent module, with at least one cookie category configured.
- **Google Tag** (`drupal/google_tag` `^1.6 || ^2.0`) — the Google Tag Manager
  integration. Both the 1.x and 2.x lines are supported.

Composer pulls both dependencies in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/eu_cookie_compliance_gtm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in **EU Cookie
Compliance** and **Google Tag** and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eu_cookie_compliance_gtm -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eu_cookie_compliance_gtm -y
```

This enables the module along with its **EU Cookie Compliance** and **Google Tag**
dependencies if they aren't already on.

## After enabling

Make sure the two host modules are actually set up: your Google Tag Manager
container ID is configured in `google_tag`, and EU Cookie Compliance has the
cookie **categories** you want to gate. Then head to
[Configuration](../configuration/index.md) to add the per‑category **GTM data**
that connects consent to your GTM tags.
