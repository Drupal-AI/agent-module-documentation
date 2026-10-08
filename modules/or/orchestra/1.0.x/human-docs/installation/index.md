# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`).
- No dependencies beyond Drupal core — the base kernel is deliberately dependency‑free.
- No extra PHP library requirements.

> **Note:** At this version Orchestra is an alpha release (1.0.0‑alpha13). Test it on
> a non‑production environment and expect the API to still be settling.

## Install with Composer

From the project root:

```bash
composer require drupal/orchestra -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/orchestra -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en orchestra -y
```

This enables the base engine only. The optional capabilities (human tasks, a browser
UI, BPMN/form editors, ECA integration, a cross‑site HTTP API, payment steps) are
separate submodules you enable individually with `drush en` when you need them.

## Verify it worked

Confirm the module is enabled (`drush pml | grep orchestra`), then review **People →
Permissions** (`/admin/people/permissions`) — you should see Orchestra's permissions
(`administer orchestra`, `administer orchestra tenants`, `access orchestra
instances`, `resolve orchestra incidents`). Grant the two "administer" permissions
only to trusted administrators. Because the engine advances workflows on cron, make
sure Drupal cron is running.
