# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core's **JSON:API** module (`jsonapi`).
- The contributed **Key Auth** module (`key_auth`) — a hard dependency, and the
  mechanism a non-browser client uses to authenticate to the endpoint.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_site -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Key Auth and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_site -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_site -y
```

Drupal enables core JSON:API and Key Auth automatically as dependencies. After
enabling, follow **Key Auth's** own documentation to issue an API key for the user
account your front end will authenticate as.

## Verify it worked

As an authenticated user (using a valid Key Auth key), request the endpoint:

```bash
curl -H "api-key: <your-key>" https://your-site.example/jsonapi/site/site
```

You should get back a JSON:API document containing the site name, slogan, front
page path, theme settings, and the other values described in the
[overview](../index.md). If you get a 403, check that the request is
authenticating as a logged-in user via Key Auth.
