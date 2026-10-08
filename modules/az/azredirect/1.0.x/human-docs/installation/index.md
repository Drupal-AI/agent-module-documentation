# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **OpenID Connect Windows Azure Active Directory** module
  (`openid_connect_windows_aad`) — a hard dependency. AZRedirect only automates the
  redirect; this module performs the actual Azure authentication, so it must be
  installed and configured with your Azure app registration.

There are no third‑party Composer or PHP library requirements of AZRedirect's own.

## Install with Composer

From the project root:

```bash
composer require drupal/azredirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`openid_connect_windows_aad` and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/azredirect -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en azredirect -y
```

Before AZRedirect is useful, configure **OpenID Connect Windows Azure Active
Directory** with your Azure app details — client ID, client secret (kept in an
environment variable, never committed), tenant, and endpoints. AZRedirect then
automates the redirect into that login flow — see
[How to use it](../index.md#how-to-use-it) on the overview page.
