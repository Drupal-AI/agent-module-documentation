# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **No other Drupal module dependencies** — the base module installs on its own.
- A **commercetools account** with an API client (Client ID, Client secret, and
  Project key). You can register a free commercetools account, or use the bundled
  demo submodule to try it without one.
- To get an actual storefront UI, you also install one of the UI modules —
  **commercetools Content** or **commercetools Decoupled** (see below).

There are no additional third‑party PHP library requirements.

## Install with Composer

Install it like any regular Drupal module. From the project root:

```bash
composer require drupal/commercetools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commercetools -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commercetools -y
```

## Add a UI module

The base module has no end‑user UI. Enable one of the UI approaches:

- **commercetools Content** (`commercetools_content`) — backend‑rendered,
  pre‑rendered pages.
- **commercetools Decoupled** (`commercetools_decoupled`) — frontend Web
  Components loading data via GraphQL.

Enable whichever you want, for example:

```bash
drush en commercetools_content -y
```

The module also ships a **demo** submodule (`commercetools_demo`) with sample B2C
and B2B commercetools accounts, so you can deploy demo content and try the full
multi‑language storefront without registering — enable it from the module's
settings **Demo** tab.

## Verify it worked

Go to **Configuration → commercetools**
(`/admin/config/system/commercetools`) and confirm the settings page loads. Then
continue with [Configuration](../configuration/index.md) to enter your
credentials.
