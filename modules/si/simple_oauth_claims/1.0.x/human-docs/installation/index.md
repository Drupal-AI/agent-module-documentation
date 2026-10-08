# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- The **Simple OAuth** module (`simple_oauth`) enabled — this is the module that
  actually issues the tokens; Simple OAuth Claims only enriches them.

There are no third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_oauth_claims -W
```

The Composer package name (`drupal/simple_oauth_claims`) matches the module's
machine name (`simple_oauth_claims`).

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Simple OAuth if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_oauth_claims -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_oauth_claims -y
```

If Simple OAuth is not yet enabled, enable it too (`drush en simple_oauth -y`),
and make sure you have Simple OAuth working — consumers, scopes and keys — before
you rely on claims.

## Verify it worked

Log in as an administrator and visit `/admin/structure/claims`. You should see
the **Claims** listing page (empty to begin with) with a button to add a new
claim. If the page loads, the module is installed correctly — head to
[Configuration](../configuration/index.md) to create your first claim.
