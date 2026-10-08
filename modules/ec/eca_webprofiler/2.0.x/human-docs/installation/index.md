# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4||^11`).
- The **ECA** module (`eca`) — the base Event‑Condition‑Action engine.
- The **Webprofiler** module (`webprofiler`) — the developer profiler this module
  extends. Install it if it isn't already present.

Drupal will enable the ECA dependency automatically. There are no third‑party PHP
library requirements.

> **Development only:** Webprofiler is intended for local/development use — it adds
> overhead and exposes internal application details. Do not enable this module (or
> Webprofiler) on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_webprofiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you install Webprofiler for development only, you may
prefer `composer require --dev drupal/webprofiler`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/eca_webprofiler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_webprofiler -y
```

This also enables `eca` and `webprofiler` if they are not already on.

## Verify it worked

With Webprofiler's toolbar enabled, load a page that triggers ECA models and open
the Webprofiler panel for that request. You should see an ECA section reporting
which events, conditions and actions fired. If it's there, the integration is
active.
