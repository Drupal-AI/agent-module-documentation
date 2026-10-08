# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`). Check the
  project page for Drupal 11 compatibility before using it there.
- The **Purge** module (`purge`) — the framework this optimizer plugs into.
- The **Akamai** module (`akamai`) — provides the actual Akamai integration and
  holds your Akamai credentials.
- The **Core Tags Queuer** submodule of Purge (`purge_queuer_coretags`).

There is also a **patch requirement**: to work correctly, this module needs a
patch applied to the Akamai module (referenced from the Akamai issue queue,
issue 3160999). Apply it via your project's patch workflow (for example
`cweagans/composer-patches`) before relying on the optimizer in production.

Setting up Purge and Akamai is itself a multi‑step task — follow the Purge and
Akamai modules' own README/documentation for the base configuration
(purgers, queuers, processors, and Akamai API setup).

## Install with Composer

From the project root:

```bash
composer require drupal/purge_akamai_optimizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
Purge and Akamai dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/purge_akamai_optimizer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purge_akamai_optimizer -y
```

Drupal will enable Purge, the Core Tags Queuer, and Akamai alongside it if
they're not already on.

## Verify it worked

Log in as a user with the **Administer Akamai** permission and go to
**Configuration → Akamai → Purge Akamai Optimizer settings**
(`/admin/config/akamai/purge-akamai-optimizer-settings`). If the settings form
loads, the module is installed. From there, see
[Configuration](../configuration/index.md) — and make sure your base Purge and
Akamai setup is complete, since this module only optimizes an already‑working
purge pipeline.
