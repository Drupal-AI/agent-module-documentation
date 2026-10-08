# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **CMRF Core** (`cmrf_core`) — provides the CiviMRF connection to CiviCRM. This
  is the only Drupal module dependency.
- A **CiviCRM** backend (local or remote) that can validate keys and return
  contact records, plus whatever CiviCRM-side configuration issues the login
  codes.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cmrf_key_authentication -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in CMRF Core and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cmrf_key_authentication -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cmrf_key_authentication -y
```

## About the JWT secret

If you plan to accept keys carried inside a signed JWT, the module verifies them
with an HS256 secret you enter on the settings form. Treat that value as a
secret: rather than typing it directly into configuration you can hold it in an
environment variable and reference it through a **Key** entity.

With DDEV, store it once and restart so the container picks it up:

```bash
ddev dotenv set .ddev/.env --cmrf-jwt-secret=<value>
ddev restart
```

(Keep `.ddev/.env` out of version control.) Then create a Key with the env
provider and select it where the settings form expects the secret. This step is
only needed for the JWT path — the URL-parameter and login-form paths do not use
it.

## Verify it worked

Log in as an administrator and open **Configuration → Web services → CMRF Key
Authentication** (`/admin/config/services/cmrf_key_authentication`). If the
settings form loads, the module is installed. See
[Configuration](../configuration/index.md) to wire up the CiviCRM lookup before
anyone can actually authenticate.
