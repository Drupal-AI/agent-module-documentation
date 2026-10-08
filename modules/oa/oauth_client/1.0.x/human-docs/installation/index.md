# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- Core's **User**, **Options**, and **Views** modules (all in core; enabled as
  needed).
- The **Simple OAuth** module (`drupal/simple_oauth:^6`) — this is the engine that
  actually issues and stores the OAuth2 consumers and tokens. OAuth2 Client is a
  workflow layer on top of it.

> **Note:** This release is an alpha (`1.0.0-alpha3`) and, at the time of writing,
> is **not covered by Drupal's security advisory policy**. Review it before relying
> on it in production, and keep it updated.

## Install with Composer

From the project root:

```bash
composer require drupal/oauth_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Simple OAuth and
any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oauth_client -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oauth_client -y
```

Drupal will enable Simple OAuth and the required core modules as dependencies.

## Verify it worked

Log in as an administrator and go to **Configuration → Web services → Consumer →
OAuth Client Request** (`/admin/config/services/consumer/oauth-client-request`).
If the request‑moderation listing loads, the module is active. Next, follow
[Configuration](../configuration/index.md) to define scopes and a client request
type before anyone can request a client.
