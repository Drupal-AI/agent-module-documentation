# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The **`onelogin/php-saml` library** (`^3.8.2 | ^4.3.2`) — this is the SAML
  toolkit that does the cryptographic validation. Composer installs it for you as
  a dependency when you require the module (see below).
- An external **SAML Identity Provider** (Okta, Entra ID/Azure AD, OneLogin,
  ADFS, Ping, Shibboleth, etc.) that you can configure to trust this site.
- An **X.509 certificate and private key** for the SP, placed in files the web
  server can read, if you want to sign requests and metadata (recommended, and
  required by most IdPs).

## Install with Composer

From the project root:

```bash
composer require drupal/saml_sp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — and, importantly here, it pulls in the required
`onelogin/php-saml` library at the same time. Requiring the module via Composer
is the supported way to satisfy that library dependency; do not try to install it
by hand.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/saml_sp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en saml_sp -y
```

## Enable the login submodule

The base module only validates SAML — it does not log anyone in. To actually
authenticate Drupal users from the IdP response, enable the bundled submodule:

```bash
drush en saml_sp_drupal_login -y
```

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **SAML SP Drupal Login** | `saml_sp_drupal_login` | Registers the callback that signs a Drupal user in once the IdP response is validated, and maps IdP attributes onto the user account. This is what most sites want. |

## Verify it worked

After enabling, load your SP metadata at `/saml/metadata.xml` — it should return
XML describing your Service Provider. Then head to
[Configuration](../configuration/index.md) to fill in the site‑wide settings and
register your Identity Provider.
