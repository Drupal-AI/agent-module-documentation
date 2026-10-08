# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **Social Auth** (`social_auth`) and **Social API** — the framework this plugin
  builds on. Composer installs them automatically.
- The OAuth client library **`openpublicmedia/oauth2-pbs`**, which Composer pulls
  in with the module.
- A **PBS** OAuth2 application: a client ID and secret obtained from PBS Digital
  Support.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_pbs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in Social Auth, Social API and the PBS OAuth2
library for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_pbs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_pbs -y
```

The Composer package name (`drupal/social_auth_pbs`) and the module machine name
(`social_auth_pbs`) match.

## Verify it worked

After enabling, follow [Configuration](../configuration/index.md) to register a PBS
app and enter your credentials. Then place the Social Auth login block (**Structure
→ Block Layout**) and confirm a **PBS** button appears on the login page.
