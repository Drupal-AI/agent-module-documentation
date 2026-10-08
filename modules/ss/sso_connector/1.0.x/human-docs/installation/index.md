# Installation

## Requirements

- **Drupal core 11.2 or 12** (`core_version_requirement: ^11.2`).
- **PHP with the OpenSSL extension** — required for RS256 signing and
  verification.
- The `firebase/php-jwt` library (`^6.10`), pulled in automatically by Composer.
- Core's **User**, **Block**, and **Help** modules (all part of Drupal core).

## Install with Composer

From the project root:

```bash
composer require drupal/sso_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sso_connector -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sso_connector -y
```

## Provision the keypair

Enabling the module is not the last step. Because the IdP signs tokens with an RSA
private key and each SP verifies them with the matching public key, you need to:

1. Generate the IdP keypair.
2. Provision the SP with the IdP's public key.

The module's `README.md` and `docs/BUNDLE.md` describe exactly how to do this for
your setup. Store the signing key in `settings.php` or State — never in exportable
configuration — so it cannot leak through a config export.

## Part of the SSO Connector bundle

This is the core module the rest of the suite builds on. Optional capabilities are
separate projects you install and enable only where you need them: **SSO Connector
OAuth**, **SAML SP**, **Social**, **2FA**, **Cookie**, **Permissions**, **Sync**,
and **Autologout**.

## Verify it worked

Log in as an administrator and open the SSO Connector admin form to confirm the
module is active, then follow the keypair provisioning steps above before testing
a login across two sites.
