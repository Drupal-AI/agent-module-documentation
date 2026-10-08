# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The base **League OAuth Login** module (`league_oauth_login`) — this is a
  provider plugin for it and cannot work without it.
- The `stevenmaguire/oauth2-bitbucket` League library, pulled in by Composer.
- A **Bitbucket OAuth consumer** (see Configuration) for the client ID and
  secret.

## Install with Composer

From the project root:

```bash
composer require drupal/league_oauth_login_bitbucket -W
```

Composer also pulls in the `stevenmaguire/oauth2-bitbucket` library. The `-W`
(`--with-all-dependencies`) flag lets it update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/league_oauth_login_bitbucket -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en league_oauth_login_bitbucket -y
```

This also enables the base `league_oauth_login` module if it is not already on.

## Verify it worked

After you have registered a Bitbucket OAuth consumer and entered its details (see
[Configuration](../configuration/index.md)), visit the login form and confirm a
Bitbucket sign‑in option appears. Click it and confirm you are redirected to
Bitbucket and returned, logged in. Test over **HTTPS**.
