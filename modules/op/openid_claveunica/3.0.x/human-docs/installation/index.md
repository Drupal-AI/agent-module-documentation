# Installation

## Requirements

- **Drupal 9.5, 10.2, or 11** (`core_version_requirement: ^9.5 || ^10.2 || ^11`).
- The contrib **OpenID Connect** module (`openid_connect`) — this module is a
  client plugin for it, and it's a hard dependency.
- **ClaveÚnica credentials** (a client ID and secret) issued for your site by the
  ClaveÚnica service.

Installing with `-W` pulls OpenID Connect in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/openid_claveunica -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the OpenID
Connect module and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openid_claveunica -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openid_claveunica -y
```

Enable OpenID Connect too if Drush doesn't pull it in automatically:

```bash
drush en openid_connect -y
```

## Verify it worked

After enabling, go to [Configuration](../configuration/index.md) to set up the
ClaveÚnica client in OpenID Connect with your credentials. Once configured, a
ClaveÚnica login option should appear on the login flow; sign in with a test
ClaveÚnica account to confirm the round trip and the complete‑profile step.
