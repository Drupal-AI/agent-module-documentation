# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Block** module (`block`) and core's **RESTful Web Services** module
  (`rest`) — both are dependencies and Drupal will enable them for you.
  You will also want core **Serialization** enabled (it comes with REST) to
  serialise the responses.
- The contributed **REST UI** module (`restui`) is strongly recommended — it gives
  you a UI for enabling and configuring the REST resource, which is otherwise a
  configuration-file exercise.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_block_layout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you want the REST UI helper, install it too:

```bash
composer require drupal/restui -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_block_layout -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_block_layout -y
```

If you installed REST UI, enable it as well so you get the configuration screen:

```bash
drush en restui -y
```

## Turn on the REST resource and grant the permission

The module does not ship an active resource configuration, so an administrator must
switch it on:

1. Go to **Configuration → Web services → REST**
   (`/admin/config/services/rest`).
2. Find the **Block Layout** resource (`block_layout`) and enable it. Choose the
   HTTP method (**GET**), the serialisation formats you want (for example `json`),
   and the authentication method appropriate for your callers.
3. Go to **People → Permissions** (`/admin/people/permissions`) and grant the
   **Access GET on Block Layout resource** permission
   (`restful get block_layout`) to the roles that should be allowed to call the
   endpoint — for anonymous decoupled access, that is the *Anonymous user* role.

## Verify it worked

Call the endpoint for a known path, in the format you enabled:

```
GET https://your-site/block-layout?_format=json&path=%2Fnode%2F1
```

You should receive a response keyed by region, listing the visible blocks for that
path, plus the matched route and — where you have view access — the target entity.
A `403` usually means the permission is not granted to the calling role; a `404`
means the path did not resolve to a route.
