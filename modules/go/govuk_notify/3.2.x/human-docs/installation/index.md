# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- A **GOV.UK Notify account** (or its Canadian/Australian equivalent) with an
  **API key** and the **templates** you intend to use already set up there.

## Install with Composer

From the project root:

```bash
composer require drupal/govuk_notify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/govuk_notify -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en govuk_notify -y
```

## Submodules

The project ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **GOV.UK Notify Views backend** | `govuk_notify_views_backend` | A Views backend for working with Notify data through Views. Enable it only if you need it. |

Enable it the same way if required:

```bash
drush en govuk_notify_views_backend -y
```

## Verify it worked

After enabling, open the module's settings page and enter your API key (see
[Configuration](../configuration/index.md)). Start with a **test** key against a
non‑production environment and send a test message through one of your Notify
templates. Confirm it appears in your Notify dashboard's delivery report before
switching to a live key.
