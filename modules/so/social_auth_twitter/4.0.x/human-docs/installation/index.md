# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Social Auth** (`social_auth`) — the framework this plugin builds on, and which
  owns the login/redirect/callback routes. Composer installs it automatically.
- An **X (Twitter) developer app** with OAuth enabled, for its API key and secret.

The Twitter OAuth2 client library is pulled in with the module; there are no
separately listed PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_twitter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in Social Auth for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_twitter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_twitter -y
```

The Composer package name (`drupal/social_auth_twitter`) and the module machine
name (`social_auth_twitter`) match.

## Verify it worked

After enabling, follow [Configuration](../configuration/index.md) to create an X
app and enter your credentials. Then place the Social Auth login block (**Structure
→ Block Layout**) and confirm a **Twitter/X** button appears on the login page.
