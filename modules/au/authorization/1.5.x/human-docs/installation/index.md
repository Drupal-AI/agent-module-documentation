# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **External Authentication** (`drupal/externalauth`, `>=1.4`) — a required
  dependency that Composer installs automatically.
- A **provider** module to supply proposals — most commonly
  **LDAP Authorization** (part of the `ldap` project). Without a provider
  plugin, a profile has nothing to reconcile.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/authorization -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install External
Authentication and update any shared dependencies as needed. Install a provider
the same way, for example `composer require drupal/ldap`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/authorization -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en authorization -y
```

## Enable the consumer and a provider

Authorization does nothing useful on its own — it needs at least one consumer and
one provider plugin.

- **Drupal Roles consumer** (bundled submodule) — grants Drupal roles as the
  target. Enable it to map onto roles:

  ```bash
  drush en authorization_drupal_roles -y
  ```

- **A provider** — supplied by an integration module. For LDAP, enable the LDAP
  Authorization module (from the `ldap` project) that provides an
  `@AuthorizationProvider` plugin, then configure your LDAP server(s) per that
  module's own docs.

## Verify it worked

Go to **Configuration → People → Authorization**
(`/admin/config/people/authorization/profile`). If the profile collection page
loads and lets you add a profile, the module is active. When you add a profile,
the **provider** dropdown should list your installed provider (for example an
LDAP provider) and the **consumer** dropdown should list **Drupal roles**. See
[Configuration](../configuration/index.md) to build the profile.
