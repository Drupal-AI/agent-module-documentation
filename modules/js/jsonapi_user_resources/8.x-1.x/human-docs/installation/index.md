# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Drupal core's **JSON:API** module (`jsonapi`).
- The contributed **JSON:API Resources** module (`jsonapi_resources`) — a hard
  dependency, and the framework the endpoints are built on.

There are no third‑party Composer or PHP library requirements.

> **Note:** this release is a **beta** (`8.x-1.0-beta2`). Review the behaviour
> checks in the [overview](../index.md) before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_user_resources -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in JSON:API Resources
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_user_resources -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_user_resources -y
```

Drupal enables core JSON:API and JSON:API Resources automatically as dependencies
if they are not on already.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep jsonapi_user_resources
```

Then test a registration against the endpoint (on a non-production environment
first), for example:

```bash
curl --location 'https://your-site.example/jsonapi/user/register' \
  --header 'Content-Type: application/vnd.api+json' \
  --header 'Accept: application/vnd.api+json' \
  --data-raw '{"data":{"type":"user--user","attributes":{"name":"test123","mail":"test@example.com","pass":"a-strong-password"}}}'
```

Check that the account is created in the state your site expects (active, blocked,
or pending approval) — this is the behaviour to confirm before going live.
