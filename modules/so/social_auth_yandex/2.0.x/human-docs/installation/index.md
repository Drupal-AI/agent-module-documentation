# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **Social Auth** (`social_auth`) — the framework this plugin builds on. Composer
  installs it (and Social API) automatically.
- A **Yandex** OAuth application, for its client ID and secret.

There are no separately listed extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_yandex -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in Social Auth for you.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_yandex -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_yandex -y
```

The Composer package name (`drupal/social_auth_yandex`) and the module machine name
(`social_auth_yandex`) match.

## Verify it worked

After enabling, register a Yandex OAuth application and enter its client ID and
secret through Social Auth's network settings. Then place the Social Auth login
block (**Structure → Block Layout**) and confirm a **Yandex** button appears on the
login page and redirects you to Yandex to sign in.
