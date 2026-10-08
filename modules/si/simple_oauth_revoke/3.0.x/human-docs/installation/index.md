# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Simple OAuth** module (`simple_oauth`) enabled — this module adds an
  endpoint to it and does nothing on its own.

There are no third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_oauth_revoke -W
```

The Composer package name (`drupal/simple_oauth_revoke`) matches the module's
machine name (`simple_oauth_revoke`).

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_oauth_revoke -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_oauth_revoke -y
```

That's all it takes. There is no configuration — the `/oauth/revoke` endpoint
becomes available as soon as the module is enabled.

## Verify it worked

Send a POST request to `/oauth/revoke` with a valid `token`, `client_id` and
`client_secret` (see the [main guide](../index.md) for a ready-to-run `curl`
example). A successful call returns HTTP 200 and the token is invalidated
afterwards. Remember that RFC 7009 requires the endpoint to return 200 even for an
unknown token, so a 200 alone confirms the endpoint is reachable — try using a
token before and after revoking it to confirm the revocation itself.
