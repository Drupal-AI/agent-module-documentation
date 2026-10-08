# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **The Salesforce Suite** (`salesforce`) — this module is an extension to it and
  provides only an authentication plugin.
- A **Salesforce connected app** configured for the client-credentials flow, with
  its consumer key, consumer secret and an integration user.

There are no submodules and no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/salesforce_oauth_client_credentials -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve the Salesforce Suite
and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/salesforce_oauth_client_credentials -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en salesforce_oauth_client_credentials -y
```

## Verify it worked

Go to **Configuration → Salesforce → Salesforce Authorization**. When you add a new
auth provider, **Salesforce OAuth Client Credentials** should appear as an available
provider type — that confirms the plugin is registered. See
[Configuration](../configuration/index.md) to set it up.
