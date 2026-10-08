# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`; the project also
  carries 9.x history).
- A **Pipedrive account** and an **API token** from it (Pipedrive → Settings →
  Personal preferences → API).
- Outbound HTTPS network access from your Drupal server to the Pipedrive API, so the
  module can reach the CRM.
- The Pipedrive PHP SDK, which Composer installs as a dependency.

The `2.x` version is a **development branch** — pin and test it carefully before
using it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/pipedrive -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Pipedrive PHP SDK
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pipedrive -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pipedrive -y
```

## Verify it worked

After enabling, provide your Pipedrive API token as described in
[Configuration](../configuration/index.md), then confirm the module can reach
Pipedrive — for example by performing a test create (a person or activity) and
checking it appears in your Pipedrive account. If the call fails, re-check the API
token and that your server can make outbound HTTPS requests to Pipedrive.
