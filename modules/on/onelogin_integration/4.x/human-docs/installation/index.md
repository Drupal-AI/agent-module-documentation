# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **`onelogin/php-saml`** v3 toolkit — the library that does all the SAML
  processing. Because you install the module with Composer, this library is pulled
  in automatically as a dependency.
- A **SAML identity provider** you control the configuration of — a OneLogin
  account, or any other SAML IdP — plus the ability to register Drupal as a
  service provider there and obtain the IdP's signing certificate.

## Install with Composer

From the project root:

```bash
composer require drupal/onelogin_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — and here it also ensures the `onelogin/php-saml` library
is installed alongside the module. Installing the module by hand (downloading a
zip) is **not** recommended, because you would then have to manage the php‑saml
library yourself.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/onelogin_integration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en onelogin_integration -y
```

## Verify it worked

Confirm the module is enabled on the **Extend** page and that its SAML settings
form opens (click **Configure** next to it). Before you can test a real login you
must complete the [Configuration](../configuration/index.md) — register Drupal as
a service provider at your IdP, paste in the IdP certificate, and enable the
signature/strict options. Then attempt an SSO login end to end and confirm you are
returned to Drupal logged in.
