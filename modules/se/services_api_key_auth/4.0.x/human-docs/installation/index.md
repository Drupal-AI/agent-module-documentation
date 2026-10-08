# Installation

## Requirements

- **Drupal 10.3, or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other contrib modules are required. To actually authenticate requests you will
  want an endpoint to protect — typically core's **RESTful Web Services** (`rest`)
  or **JSON:API** (`jsonapi`) module.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/services_api_key_auth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/services_api_key_auth -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en services_api_key_auth -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Web services → API Key
Authentication** (`/admin/config/services/api-key-auth`). You should see the API key
listing, from which you can add your first key. Nothing authenticates until you
create a key and attach the provider to an endpoint — see
[Configuration](../configuration/index.md).

## Keep keys out of exported config

Before you create any keys, decide how you will keep them out of version control.
Because API keys are stored as configuration entities with the key value in
cleartext, `drush cex` will otherwise commit live credentials to git. Exclude
`services_api_key_auth.api_key.*` from export using `config_ignore` or
`config_split`, and treat any key already exported as compromised.
