# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Nonce Generator** (`nonce_generator`) — required; it provides the
  per‑request nonce and CSP header handling this module builds on.
- Core's **Path Alias** module (`path_alias`) — enabled automatically as a
  dependency.
- A **Piwik PRO account and container** (for the container URL and site ID).
- Recommended: a working **CSP configuration** for your site that allows the
  configured Piwik PRO endpoints. No other libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/nonce_piwik_plugin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Nonce Generator
and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nonce_piwik_plugin -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Nonce Generator and this module together (Drush will enable
`nonce_generator` and `path_alias` automatically as dependencies, but naming them
is harmless):

```bash
drush en nonce_generator nonce_piwik_plugin -y
```

## Verify it worked

Go to **Configuration → Security → Nonce Piwik Plugin**
(`/admin/config/security/nonce-piwik-plugin`). If the form loads, the module is
active — but no tracking is emitted until you enter your Piwik PRO container URL
and site ID and enable tracking. Continue to
[Configuration](../configuration/index.md).
