# Installation

## Requirements

Subrequests needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Serialization** module (`serialization`), which Drupal enables
  automatically as a dependency.
- The **`galbar/jsonpath`** PHP library (`^1.0`), used to evaluate the
  `{{requestId.body@$.jsonpath}}` response-embedding tokens. Composer pulls this in
  for you when you require the module — do not try to install the module by copying
  files, or the library will be missing.

There is no separate settings form and no database schema to install.

## Install with Composer

From the project root:

```bash
composer require drupal/subrequests -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and ensures the `galbar/jsonpath` library is installed
alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/subrequests -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en subrequests -y
```

This registers the `/subrequests` route and the **Issue subrequests** permission.
Core's Serialization module is enabled automatically if it was not already on.

## Grant the permission

The endpoint is gated by the `issue subrequests` permission. Nobody can call it until
you grant that permission to a role:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find **Issue subrequests** and tick it for the role(s) that should be allowed to
   batch requests — typically a dedicated API/integration role.
3. Save permissions.

## Verify it worked

POST a small blueprint to `/subrequests` as a user in a role that has the permission,
for example a single `view` subrequest against an endpoint you know returns data. A
successful call comes back as **HTTP 207 (Multi-Status)**. Add `?_format=json` to get
the response as one JSON object keyed by each subrequest's `requestId`.

There is no configuration page to visit — the module is ready as soon as it is
enabled and the permission is granted.
