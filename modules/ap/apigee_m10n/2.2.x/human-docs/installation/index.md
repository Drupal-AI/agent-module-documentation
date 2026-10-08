# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`) — but see the
  critical caveat below regarding Drupal 11.4.
- The contributed **Apigee Edge** module (`apigee_edge`) — a hard dependency,
  which in turn requires the **Key** module and a working Apigee organization.
- An Apigee account with **monetization enabled**.

## Critical compatibility caveat — check this first

This module **could not be installed on Drupal 11.4** during testing. The cause is
in its dependency `apigee_edge` 4.1.0, which injects the container parameter
`%main_content_renderers%` — a parameter Drupal 11.4 core no longer defines. The
container then fails to compile:

```
DefinitionErrorExceptionPass: You have requested a non-existent parameter "main_content_renderers".
```

This is a hard failure that brings down the site and Drush, and because it happens
**during module installation** it can leave other modules half-installed (enabled
but with their install hooks never run), requiring a database restore to recover.

**Before installing:** confirm that `apigee_edge` has a release compatible with the
**exact** core version you are running. Do not add this module to a batch install
on Drupal 11.4 — if it fatals it can take the rest of the batch down with it.

## Install with Composer

Once you have confirmed a compatible core/Apigee Edge combination, from the project
root:

```bash
composer require drupal/apigee_m10n -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Apigee Edge.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/apigee_m10n -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en apigee_m10n -y
```

If enabling fails with the `main_content_renderers` error above, do **not** retry
blindly — restore the database and revisit the compatibility caveat before trying
again. Configure Apigee Edge (connection and Key-backed credentials) before
expecting monetization features to work.
