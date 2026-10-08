# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- **Social API** (`social_api`) and **Social Auth** (`social_auth`) — the framework
  this plugin builds on. Composer installs both automatically.
- A **Strava** API application, for its client id and secret.

There are no separately listed PHP library requirements; the Strava OAuth2 SDK is
pulled in with the module.

> **Note on support status:** this project is marked *seeking new maintainer* and
> its releases are **not covered by Drupal's security advisory policy**. Weigh that
> before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_strava -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in Social Auth and Social API for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_strava -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_strava -y
```

The Composer package name (`drupal/social_auth_strava`) and the module machine name
(`social_auth_strava`) match.

## Verify it worked

After enabling, follow [Configuration](../configuration/index.md) to register a
Strava app and enter your credentials. Then place the Social Auth login block
(**Structure → Block Layout**) and confirm a **Strava** button appears on the login
page.
