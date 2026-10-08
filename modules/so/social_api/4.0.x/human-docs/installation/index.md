# Installation

## Requirements

- **Drupal 9.5, 10 or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **OpenSSL** PHP extension (`ext-openssl`) — used to encrypt stored access
  tokens. It is part of virtually every PHP build.
- The **`league/oauth2-client`** library (`^2.0`) — pulled in automatically by
  Composer.

Social API has no dependency on other Drupal modules, but on its own it does very
little — you will normally install it together with an integration such as Social
Auth or Social Post (which declare it as their dependency) plus a per‑network add‑on.

## Install with Composer

From the project root:

```bash
composer require drupal/social_api -W
```

The `-W` (`--with-all-dependencies`) flag pulls in `league/oauth2-client` and updates
shared dependencies as needed. In most cases you will instead require the integration
you actually want (for example `composer require drupal/social_auth -W`), and Composer
will bring Social API along automatically.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_api -y
```

Social API has **no submodules**. Enabling it adds the *Social API* landing page and
its five permissions, but no network integration — that comes from the companion
modules you install next.

## Grant the permissions

Social API declares five permissions, all named *Administer social api …*
(configuration, authentication, autoposting, blocks, widgets). Grant the ones
relevant to the integrations you use to the roles that should manage them, e.g.:

```bash
drush role:perm:add administrator 'administer social api authentication'
```

## Verify it worked

Go to **Configuration → Social API** (`/admin/config/social-api`). The landing page
should load. As you add integrations (Social Auth, Social Post, …), their settings
pages will appear grouped under it.

For the plugin type and base classes used to build an integration, see the
[`agent/`](../agent/start.md) reference.
