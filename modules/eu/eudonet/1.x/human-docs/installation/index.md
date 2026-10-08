# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Eudonet CRM **API access and credentials** (obtained from your Eudonet
  environment).

There are no contrib module dependencies listed, and no third‑party PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/eudonet
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eudonet`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eudonet -y
```

## Configure the connection

Before your integration can talk to Eudonet, enter the API base URL and login
parameters on the settings form at **Configuration → Services → Eudonet API
configuration** (`/admin/config/services/eudonet`), then use **Try auth request** to
verify them. See the "How to use it" section of the [overview](../index.md) for the
details.

## Verify it worked

Confirm the module is enabled (**Extend**, or `drush pml | grep eudonet`). Since it
is a client library, the real test is whether **Try auth request** succeeds on the
settings form — and then whether your integration code (or a dependent module) can
make a call against the Eudonet API using the credentials you provided.
