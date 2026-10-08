# Installation

## Requirements

Acquia AI Gateway is a provider plugin for the AI module and needs secure key
storage:

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **AI** module (`ai`) — the framework this provider plugs into.
- The **Key** module (`key`) — so the gateway API key is stored as a secret.
- Access to an **Acquia AI Gateway** subscription, which provides the gateway URL
  and API key (usually pre-provisioned by Acquia).

There are no extra PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_acquia -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies such as the AI and Key modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_provider_acquia -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_acquia -y
```

Drupal enables `ai` and `key` as dependencies if they are not already on.

## After enabling

Provide the gateway host and API key through environment variables (see
[Configuration](../configuration/index.md)), then visit the provider settings form
to confirm the connection. The provider has no permissions of its own — its
settings page uses the AI module's **Administer AI providers** permission.
