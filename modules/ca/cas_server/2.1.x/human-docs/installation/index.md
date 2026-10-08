# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **User** module (always present).
- **HTTPS.** The CAS protocol passes authentication tickets around, so the site
  **must** be served over TLS. Do not run this in production over plain HTTP.
- **Do not enable the CAS *client* module on the same site.** This module makes
  Drupal a CAS *server*; the client module makes Drupal delegate its own login to an
  external CAS server. Running both together is unsupported and will conflict.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cas_server -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cas_server -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cas_server -y
```

Or enable **Central Authentication System (CAS) Server** from *Extend*
(`/admin/modules`).

## Optional submodule — CAS Attributes

The project ships a **CAS Attributes** submodule (`cass_attributes`) that
demonstrates how to add or transform the attributes released to a service (it
subscribes to the module's attribute‑alter event). Enable it only if you need that
example or want to build on it:

```bash
drush en cass_attributes -y
```

## After enabling

1. Confirm the site is on **HTTPS**.
2. Go to **Configuration → People → CAS Server → Settings** to set ticket lifetimes,
   the username attribute, and messages.
3. Register your service definitions and grant the appropriate roles the
   "log in to service" permissions — see [Configuration](../configuration/index.md).
