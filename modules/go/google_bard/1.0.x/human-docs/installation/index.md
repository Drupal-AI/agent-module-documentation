# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- A signed‑in Google account whose Bard session cookies you can capture — this is
  the module's only means of authentication.

There are no additional Composer library or PHP requirements.

> **Heads up:** this module is deprecated and unsupported for security coverage.
> Use it only for local experiments, and see the notes in
> [Configuration](../configuration/index.md) about treating the cookies as
> credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/google_bard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_bard -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_bard -y
```

## Verify it worked

Visit **Configuration → System → Google Bard settings**
(`/admin/config/system/google-bard-settings`) — the cookie settings form should
load. Until you enter valid cookies there, the query form at `/google-bard` will
not return answers. Continue to [Configuration](../configuration/index.md).
