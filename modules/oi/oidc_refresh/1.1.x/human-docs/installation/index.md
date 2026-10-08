# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- The **OpenID Connect Client** module (`oidc`) — required; OIDC Refresh only makes
  sense on a site that already logs users in via OIDC, and it relies on OIDC to do
  the actual token refresh. Note that OIDC itself needs the PHP **`gmp`** extension —
  see the OIDC module's installation notes.

There are no third‑party Composer libraries of its own to install.

## Install with Composer

From the project root:

```bash
composer require drupal/oidc_refresh -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the OIDC module if it isn't present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oidc_refresh -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oidc_refresh -y
```

This also enables OIDC if it isn't already on.

## Verify it worked

After enabling it and setting an interval (see
[Configuration](../configuration/index.md)), log in as an OIDC user, open a page, and
leave it — you should see periodic background AJAX requests being made (visible in
your browser's network tools), keeping the session alive.
