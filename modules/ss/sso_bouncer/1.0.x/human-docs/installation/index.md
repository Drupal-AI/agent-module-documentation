# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **OpenID Connect** module (`openid_connect`).
- An existing **Keycloak SSO client** configured through OpenID Connect.
- OpenID Connect **role mappings** defined at
  `/admin/config/people/openid-connect/settings` — the group claims those
  mappings expose are what SSO Bouncer checks against.

Note: this is an early (alpha) release and is not covered by Drupal's security
advisory policy, so review it carefully before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/sso_bouncer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sso_bouncer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sso_bouncer -y
```

Or enable **SSO Bouncer** from the Extend page (`/admin/modules`).

## Verify it worked

Visit **Configuration → People → SSO Bouncer Settings**
(`/admin/config/people/sso-bouncer`). If the settings form loads, the module is
installed — continue to [Configuration](../configuration/index.md) to enable the
gate and select the client ID. You can also check the current state from the
command line with `drush sso_bouncer:status`.
