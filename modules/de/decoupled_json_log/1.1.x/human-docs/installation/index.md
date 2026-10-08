# Installation

## Requirements

- **Drupal 11.3 or Drupal 12** (`core_version_requirement: ^11.3 || ^12`).
- **PHP 8.5 or newer** (`php: >=8.5`) and the `ext-json` extension (bundled with
  PHP).
- The **JSON Field** module (`drupal/json_field` **^1.7**) — a hard dependency,
  because log entries are stored as JSON.

> **Upgrading from 1.0.x?** Note the raised requirements: 1.0.x runs on Drupal
> 11.2, while 1.1.x needs Drupal 11.3+/12 and PHP 8.5+. Make sure your environment
> meets them before requiring this release.

## Install with Composer

From the project root:

```bash
composer require drupal/decoupled_json_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the JSON Field
dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/decoupled_json_log -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en decoupled_json_log -y
```

Enabling this module pulls in JSON Field automatically if it is not already on.

## Post‑installation steps

1. **Grant the create permission.** Go to **People → Permissions**
   (`/admin/people/permissions`) and give the **Create json logs** permission to
   the roles that should be able to create logs. For a public mobile or web app
   this is often the **anonymous** role — that is by design.
2. **Decide what you want to log.** The module ships an `error` bundle out of the
   box. Add more log types (for example `warning` or `notification`) at
   **`/admin/structure/log_json_types`** if you need them — each type can carry its
   own rate‑limit overrides.
3. **Confirm the limits.** Review the rate‑limit and payload‑size settings at
   **`/admin/config/decoupled_json_log`** — see
   [Configuration](../configuration/index.md).

## Verify it worked

From your front end (or `curl`), POST a small test entry to the JSON:API resource
`log_json--error`. For a cookie‑authenticated request you must include an
`X-CSRF-Token` header (fetch one from `/session/token`). A successful create
confirms the endpoint is reachable and the create permission is set correctly. Then
confirm the entry appears for an admin at **`/admin/content/log-json`** — remember
you cannot read it back through the API by design.
