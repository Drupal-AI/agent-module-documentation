# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other module dependencies and no third-party Composer libraries.
- On the other side of the exchange you need an **external SAML 2.0 Identity
  Provider** (Okta, Azure AD / Entra ID, ADFS, Keycloak, OneLogin, etc.) that you can
  administer, so you can register Drupal as a Service Provider there.

## Install with Composer

From the project root:

```bash
composer require drupal/miniorange_saml -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/miniorange_saml -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en miniorange_saml -y
```

You can also enable it from **Extend** (`/admin/modules`).

## A note on secrets

Most of what you enter is not secret — the IdP's issuer, its SSO URL, and its **public**
signing certificate are safe to store as configuration. If you register a paid plan,
any licence key or account secret should be kept out of version-controlled
configuration: store such values in an environment variable (for example via DDEV's
`ddev dotenv set`) rather than committing them. Never paste a private signing key into
plain configuration or a public repository.

## What happens next

Enabling the module does **not** turn on SSO — no login link appears until you enter
the IdP details and the module counts as configured. Head to
[Configuration](../configuration/index.md) to complete the SP/IdP exchange.
