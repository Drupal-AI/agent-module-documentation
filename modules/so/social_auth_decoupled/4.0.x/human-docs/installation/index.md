# Installation

## Requirements

Social Auth Decoupled needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5||^10||^11`).
- The **Social Auth** module (`social_auth`) and core's **System** module. Social
  Auth builds on the Social API framework, which Composer pulls in for you.

There are no PHP extension or third‑party library requirements.

> **A note on status:** this project is **not** covered by Drupal's security
> advisory policy and is currently **seeking a new maintainer**. Weigh that before
> relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_decoupled -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update Social
Auth and the Social API dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_decoupled -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_decoupled -y
```

Drupal enables the Social Auth dependency at the same time if it is not already on.

## Next step

This is a base module — pair it with a decoupled social‑login implementation and
configure the provider credentials on that module. There is no settings form on
Social Auth Decoupled itself. Remember to serve the whole flow over HTTPS and to
scope the origins (CORS) allowed to drive it.
