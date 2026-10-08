# Installation

## Requirements

TAPIS Auth needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **TAPIS Tenant** (`tapis_tenant`) — the tenant this module authenticates
  against. Install and configure it first.

Composer resolves TAPIS Tenant (and its own dependencies, including Key) for you.
There are no extra PHP or third-party library requirements. Note this release is a
beta (version 1.4.1-beta), so treat it accordingly on production sites.

## Install with Composer

From the project root:

```bash
composer require drupal/tapis_auth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in TAPIS Tenant and
the other dependencies as needed. (The Composer package name, `drupal/tapis_auth`,
matches the module's machine name, `tapis_auth`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tapis_auth -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tapis_auth -y
```

## Verify it worked

Confirm that **TAPIS Tenant** is enabled and that your tenant's service
credentials are stored securely (as a Key backed by an environment variable).
With that in place, TAPIS Auth is ready — it will mint per-user JWT tokens on
demand the first time each user performs a TAPIS operation through one of the
other TAPIS modules.
