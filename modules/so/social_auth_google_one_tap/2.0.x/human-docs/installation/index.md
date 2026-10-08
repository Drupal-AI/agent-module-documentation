# Installation

## Requirements

Social Auth Google One Tap needs:

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5||^11`).
- The **Social Auth** module and the **Social Auth Google** module
  (`social_auth_google`) — this module enhances Google login and reuses its
  configuration.
- The **`google/apiclient`** PHP library (version `^2.15`), used to verify the
  Google ID token server‑side. Install it via Composer.

## Install with Composer

From the project root, add the module and the Google API client library:

```bash
composer require drupal/social_auth_google_one_tap -W
composer require google/apiclient:"^2.15"
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update Social
Auth and Social Auth Google as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_google_one_tap -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_google_one_tap -y
```

Make sure **Social Auth Google** is installed and configured first (see
Configuration), since this module builds directly on it.

## Next step

The prompt will not work until Social Auth Google has a valid Client ID and your
Google Cloud project lists your site's domain as an authorized JavaScript origin —
continue to [Configuration](../configuration/index.md).
