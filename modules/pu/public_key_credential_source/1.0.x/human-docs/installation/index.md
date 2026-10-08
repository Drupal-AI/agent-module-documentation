# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **JSON Field** (`json_field`) — the module stores each credential source as a
  JSON object in a JSON field.
- **WebAuthn Framework** (`webauthn_framework`) — provides the underlying
  `web-auth/webauthn-lib` library used to work with WebAuthn credentials and to
  verify signatures and the sign counter.
- **Universal Device Detection** — used to parse the authenticator's user‑agent
  string (pulled in through the WebAuthn dependency chain).

This is an **experimental, alpha‑stage** module (version 1.0.0‑alpha7) with
*not-covered* security advisory coverage. Treat it accordingly: test it away from
production and review it against your own security requirements first.

## Install with Composer

From the project root:

```bash
composer require drupal/public_key_credential_source -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
JSON Field, WebAuthn Framework, and related dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/public_key_credential_source -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en public_key_credential_source -y
```

Drupal enables the JSON Field and WebAuthn Framework dependencies along with it.

## Verify it worked

After enabling, the **Public Key Credential Source** entity type exists and is
ready for a WebAuthn/passkey module to store credentials in. There is no settings
page to visit; the next step is to review the module's **permission** at **People
→ Permissions** (`/admin/people/permissions`) and to install a passkey module
(such as Decoupled Passkeys) that builds an authentication flow on top of this
store.
