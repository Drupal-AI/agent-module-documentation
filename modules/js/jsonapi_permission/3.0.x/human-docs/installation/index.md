# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **JSON:API** (`jsonapi`) module — the only dependency.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_permission -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_permission -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_permission -y
```

Drupal enables JSON:API as a dependency if it is not already on.

> **Important:** enabling this module introduces the `Access JSON:API` gate. Before
> or immediately after enabling it, grant the permission to the roles that
> legitimately use the API (see the [overview](../index.md)) — otherwise a role
> that currently relies on JSON:API, including your decoupled front end's service
> account, may lose access.

## Assign the permission

At **People → Permissions** (`/admin/people/permissions`), grant **`Access
JSON:API`** to the roles that should reach the API, and leave it unchecked for
those that should not.

## Verify it worked

Test in both directions after saving permissions:

- As a role that **has** the permission (for example your front end's service
  account), confirm a JSON:API request still succeeds.
- As a role that **lacks** it (for example Anonymous user), confirm a JSON:API
  request is now blocked.
