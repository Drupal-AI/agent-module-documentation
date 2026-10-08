# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **JSON:API** (`jsonapi`) module.
- The **JSON:API Resources**
  ([`jsonapi_resources`](https://www.drupal.org/project/jsonapi_resources))
  module — this is what makes the custom address endpoints possible.
- The **Address**
  ([`address`](https://www.drupal.org/project/address)) module, which supplies the
  country and subdivision data being exposed.

Composer installs the contributed dependencies for you; core's JSON:API is enabled
as a dependency.

> **Not covered by the security advisory policy.** This project isn't tracked
> through Drupal's official security process — worth weighing before using it on
> a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_address -W
```

The `-W` (`--with-all-dependencies`) flag pulls in JSON:API Resources, Address,
and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_address -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_address -y
```

This also enables core JSON:API, JSON:API Resources, and Address if they aren't
already on.

## Grant the permissions

The endpoints are gated behind two permissions. At **People → Permissions**
(`/admin/people/permissions`), grant the roles that need API access:

- **`jsonapi_address access address data`** — for the country/subdivision
  endpoints.
- **`jsonapi_address access postal code validation`** — for postal-code
  validation.

## Verify it worked

As a user (or API consumer) holding the address-data permission, request
`/jsonapi/address/country`. A JSON response listing countries confirms the module
is working. If you get an access error, re-check the permission grant above.
