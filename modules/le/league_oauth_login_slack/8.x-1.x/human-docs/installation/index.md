# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- The base **League OAuth Login** module (`league_oauth_login`) — this is a
  provider plugin for it and cannot work without it.
- A **Slack OAuth app** (see Configuration) for the client ID and secret.

Composer pulls in the League Slack OAuth2 client library it needs.

## Install with Composer

From the project root:

```bash
composer require drupal/league_oauth_login_slack -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the League client
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/league_oauth_login_slack -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en league_oauth_login_slack -y
```

This also enables the base `league_oauth_login` module if it is not already on.

## Verify it worked

After you have registered a Slack OAuth app and entered its details (see
[Configuration](../configuration/index.md)), visit the login form and confirm a
Slack sign‑in option appears. Click it and confirm you are redirected to Slack and
returned, logged in. Test over **HTTPS**.
