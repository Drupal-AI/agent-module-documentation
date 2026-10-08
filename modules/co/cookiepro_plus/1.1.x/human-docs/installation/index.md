# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Path Alias** module (`path_alias`) — enabled automatically as a
  dependency.
- A **CookiePro / OneTrust account** with a Script ID. The module injects
  OneTrust's hosted scripts; it does not provide the consent service itself.

There are no third-party Composer or PHP library requirements.

**Suggested companion modules** (optional, install only if you need them):

- [Consent Support](https://www.drupal.org/project/consent_support) — block
  content at render time so CookiePro can unblock it on consent.
- [Google Tag](https://www.drupal.org/project/google_tag) — integrate with Google
  Tag Manager (GTM) behind consent.
- [Token Filter](https://www.drupal.org/project/token_filter) — required if you
  want to place the module's tokens inside CKEditor content.

## Install with Composer

From the project root:

```bash
composer require drupal/cookiepro_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookiepro_plus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookiepro_plus -y
```

## Right after enabling

Two things to do before you rely on it:

1. **Grant the permission.** All configuration is gated behind the restricted
   **Administer CookiePro Plus configuration** permission. Assign it to your
   administrator role at *People → Permissions* if it isn't already.
2. **Review the shipped IP whitelist.** The module installs with a default IP
   range in its whitelist. Any visitor from a whitelisted IP bypasses the consent
   banner entirely (and page caching is disabled for them), so you should clear or
   replace this value before going live — see the
   [Configuration](../configuration/index.md#ip-whitelist-important-security-note)
   page.

This module has no submodules. Continue to [Configuration](../configuration/index.md)
to enter your Script ID and tune the rest.
