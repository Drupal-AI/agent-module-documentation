# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Simple OAuth** module (`simple_oauth`) enabled — this module extends its
  redirect-URI validation and does nothing on its own.

There are no third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_oauth_redirect_uri_wildcard -W
```

The Composer package name (`drupal/simple_oauth_redirect_uri_wildcard`) matches
the module's machine name (`simple_oauth_redirect_uri_wildcard`).

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_oauth_redirect_uri_wildcard -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_oauth_redirect_uri_wildcard -y
```

Once enabled, you can use a subdomain wildcard in the **Redirect URI** field of
any Simple OAuth consumer. There is no configuration form — see the
[main guide](../index.md) for how to enter a wildcard pattern, and please read
its security notes first: wildcard redirect URIs inherently weaken OAuth's
exact-match protection, so only use one where you control every subdomain it can
match.

## Verify it worked

Edit a Simple OAuth consumer, set its **Redirect URI** to a pattern such as
`https://*.example.com/callback`, and save it. Then start an OAuth authorization
flow with a redirect URI that fits the pattern (for example
`https://preview-123.example.com/callback`). If the flow proceeds instead of
being rejected for an unregistered redirect URI, the module is working.
