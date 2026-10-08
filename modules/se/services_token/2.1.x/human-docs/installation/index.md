# Installation

## Requirements

- **Drupal 10, or 11** (`core_version_requirement: ^10 || ^11`).
- No other contrib modules are required, but the module is meant to authenticate web
  services: enable core's **RESTful Web Services** (`rest`) module to protect REST
  resources, and/or pair it with the contrib **Services** module for its endpoint.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/services_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/services_token -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en services_token -y
```

## Grant the token-generation permission

Tokens can only be minted by roles that hold the **`generate services token`**
permission. Go to **People → Permissions** (`/admin/people/permissions`) and grant
it to the roles that should be allowed to create tokens (for example an
"API client" role), then save.

## Optional: settings.php knobs

The module has no admin form; its tunables live in `settings.php`:

```php
// Dedicated HMAC signing key. If unset, it falls back to Drupal's private key
// plus the hash salt. Setting your own is recommended.
$settings['services_token_private_key'] = '...';

// Token lifetime in seconds (default 2592000 = 30 days).
$settings['services_token_ttl'] = 2592000;

// Authentication realm string (default "<site name> API").
$settings['services_token_realm'] = 'My API';
```

## Verify it worked

With the permission granted, request a token as an allowed user by POSTing to
`/services_token/generate` (see the "How to use it" section of the
[main guide](../index.md)). A successful call returns a JSON body with `expires` and
`token` fields. Remember to always use HTTPS.
