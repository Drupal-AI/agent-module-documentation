# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Path Alias** module (`path_alias`).
- The **Consumers** contrib module (`consumers:consumers`) — Composer pulls it in
  automatically with the command below.
- No third‑party PHP library requirements.

The current release is a **beta** (`1.0.0-beta2`), tested mainly with a single
default consumer alongside **GraphQL 4.x**, and the project is **not covered by
Drupal's security advisory policy**. Test other setups before relying on them.

## Install with Composer

From the project root:

```bash
composer require drupal/consumer_base_url -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Consumers
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/consumer_base_url -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en consumer_base_url -y
```

This enables Consumer Base URL along with the Consumers and Path Alias modules if
they are not already on.

## Verify it worked

Go to **Configuration → Web services → Consumers**
(`/admin/config/services/consumer`) and edit a consumer — you should now see a
**base URL** field on the consumer form. Fill it in as described in "How to use it"
in the [overview](../index.md), save, and clear caches if needed.
