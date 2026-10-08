# Installation

## Requirements

TFA Headless needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **TFA** module (`tfa:tfa`) — the two-factor framework it builds on.
- Core's **REST** module (`drupal:rest`) — used to expose the endpoints.
- The **Simple OAuth** module (`simple_oauth:simple_oauth`) — the OAuth server
  whose `/oauth/token` response this module gates.
- **REST UI** is a recommended "nice to have" — it gives you an admin screen for
  enabling the endpoints, rather than editing configuration by hand.

There are no third-party PHP or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tfa_headless -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including TFA and Simple OAuth if they are not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tfa_headless -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tfa_headless -y
```

Drupal will enable the required dependencies (TFA, REST, User, Simple OAuth) at the
same time. If you want the friendlier endpoint screen, also enable REST UI
(`drush en restui -y`).

## Enable the endpoints

After installation, switch the endpoints on under **Configuration → Web services →
REST** (`/admin/config/services/rest`). This is where the four `/api/totp/*` routes
are activated.

## Verify it worked

Confirm that Simple OAuth is configured with its keys, then test the full flow with
an API client: generate a TOTP seed, register the user, and attempt to obtain a
token at `/oauth/token`. The critical check is that **no usable token is issued
until the second factor is completed** — try the refresh-token path and any
pre-existing tokens too, and serve everything over HTTPS.
