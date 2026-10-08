# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **Social API** and **Social Auth** (`social_auth`) — the framework this plugin
  builds on. Composer installs them automatically.
- **Composer** on the host (Social Auth Vipps requires it; use the sibling *Vipps
  Login* module if your hosting cannot run Composer).
- A working **Vipps** account with a login/merchant application — see the note
  below on the sign-up lead time.

There are no separately listed PHP library requirements; the Vipps OAuth2 client is
pulled in with the module.

> **Sign-up lead time:** apply to use **Vipps på Nett**. After one to two days you
> receive an email with login details for the **Vipps Developer Portal**, where you
> retrieve the API credentials used to configure the module.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_vipps -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in Social Auth and Social API for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_vipps -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_vipps -y
```

The Composer package name (`drupal/social_auth_vipps`) and the module machine name
(`social_auth_vipps`) match.

## Verify it worked

After enabling, follow [Configuration](../configuration/index.md) to register a
Vipps app and enter your credentials. Then place the Social Auth login block
(**Structure → Block Layout**) and confirm a **Vipps** button appears on the login
page.
