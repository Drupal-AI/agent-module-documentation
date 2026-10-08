# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Rules** module (`rules`) — this module contributes an action to Rules and does
  nothing on its own.
- No third‑party Composer libraries or PHP extensions are required.

This project is not covered by Drupal's security advisory policy; given the SSRF
considerations described in [Configuration](configuration/index.md), review how you
use it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/rules_http_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Rules if it isn't already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rules_http_client -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rules_http_client -y
```

## Verify it worked

Go to **Configuration → Workflow → Rules** (`/admin/config/workflow/rules`), create or
edit a reaction rule, and add an action. The HTTP‑request action provided by this
module should appear in the list of available actions.
