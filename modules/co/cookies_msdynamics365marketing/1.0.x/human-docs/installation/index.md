# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **COOKiES Consent Management** module (`cookies`) — this is the only
  dependency, and it does the actual consent-banner work. Install and configure it
  first.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cookies_msdynamics365marketing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the COOKiES module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookies_msdynamics365marketing -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookies_msdynamics365marketing -y
```

Enabling this module also enables COOKiES if it is not already on.

## Verify it worked

With COOKiES configured and a Dynamics 365 Marketing form on a page, open your
browser console and call `d365mktConfigureTracking();`. Before granting consent it
should report `Anonymize: true`; after granting consent, `Anonymize: false`. If
the function is not defined, the integration is not wired up correctly — recheck
that both COOKiES and this module are enabled and that COOKiES is configured.
