# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

Page Not Found Redirect is deliberately lightweight — it has **no module dependencies**
beyond Drupal core, and no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pagenotfound_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pagenotfound_redirect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pagenotfound_redirect -y
```

## Verify it worked

Enabling the module alone does **not** change your 404 page yet — you still need to point
Drupal's 404 handler at `/friendly-404`. After you do that (see
[Configuration](../configuration/index.md)), visit a made‑up URL on your site and confirm
you see your custom page and that the browser/tooling still reports an HTTP 404 status.
