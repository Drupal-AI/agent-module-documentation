# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Content Security Policy** module (`csp`) — this is a hard dependency, and
  Composer will pull it in for you. CSP Google Supported Domains only extends the
  policies that `csp` produces; it does nothing on its own.
- No third‑party PHP or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/csp_google -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required `csp` module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/csp_google -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en csp_google -y
```

Drupal enables the `csp` dependency automatically if it isn't already on.

## Verify it worked

Go to **Configuration → System → Content Security Policy**
(`/admin/config/system/csp`) and edit any policy. You should now see an **"Add
Google supported domains"** checkbox on the policy form. Enabling it and saving,
then reloading a page and inspecting the `Content-Security-Policy` response
header, confirms the Google domains are being appended. See the
[main guide](../index.md#how-to-use-it) for the full walkthrough and the header‑length
caution.
