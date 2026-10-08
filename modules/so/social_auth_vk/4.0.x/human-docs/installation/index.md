# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **Social Auth** (`social_auth`) and **Social API** — the framework this plugin
  builds on. Composer installs them automatically.
- A **VK** application, for its client ID and secret. (The module is built on VK's
  official PHP SDK, which is pulled in with the package.)

There are no separately listed extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_vk -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in Social Auth and Social API for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_vk -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_vk -y
```

The Composer package name (`drupal/social_auth_vk`) and the module machine name
(`social_auth_vk`) match.

## Upgrading to 4.x from an earlier version

If you already ran an older release, do a clean swap rather than an in-place
update:

```bash
drush pmu social_auth_vk
composer require 'drupal/social_auth_vk:^4.0'
drush cr
drush en social_auth_vk -y
```

Afterwards, re-check the **Client ID** and **Client secret** on the settings page
and update the **Redirect URL** in your VK application to match the *Authorized
redirect URL* shown there.

## Verify it worked

After enabling, follow [Configuration](../configuration/index.md) to register a VK
app and enter your credentials. Then place the Social Auth login block (**Structure
→ Block Layout**) and confirm a **VKontakte** button appears on the login page.
