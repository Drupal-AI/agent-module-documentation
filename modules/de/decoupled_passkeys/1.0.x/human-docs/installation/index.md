# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- Three module dependencies, which Composer and Drupal will bring in:
  - **JSON‑RPC** (`jsonrpc`) — carries the registration/login ceremonies to your
    front end.
  - **Public Key Credential Source** (`public_key_credential_source`) — stores the
    users' registered passkey credentials.
  - **WebAuthn Framework** (`webauthn_framework`) — performs the actual WebAuthn
    verification, using the `web-auth` PHP library (v4).
- **HTTPS** on both Drupal and your front end — WebAuthn requires a secure context.

Because it is an **experimental / alpha** module, expect to write **custom
integration code** on the front end; there is no drop‑in UI.

## Install with Composer

From the project root:

```bash
composer require drupal/decoupled_passkeys -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in JSON‑RPC, Public
Key Credential Source, the WebAuthn Framework, and the underlying `web-auth`
library, updating shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/decoupled_passkeys -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en decoupled_passkeys -y
```

Enabling it pulls in the three dependency modules automatically if they are not
already on.

## Configure the relying party and permissions

1. **Set the WebAuthn relying‑party details** (RP‑ID, origin, user verification) in
   the **WebAuthn Framework** module so they match your domain exactly. This is the
   heart of the security guarantee — a wrong origin or RP‑ID undermines it.
2. **Assign permissions** at **People → Permissions**
   (`/admin/people/permissions`) so that only the intended roles can reach the
   JSON‑RPC passkey endpoints.
3. **Follow the project README** for the exact JSON‑RPC method names and the
   front‑end integration steps — since the module is experimental, the README is
   the current source of truth.

## Verify it worked

Because there is no built‑in UI, verification means exercising the JSON‑RPC
endpoints from your front‑end integration: register a passkey for a test user, then
authenticate with it, and confirm the WebAuthn ceremony completes server‑side (the
user is genuinely logged in, not merely reported as such by the client). Confirm the
whole flow runs over HTTPS and that the RP‑ID/origin checks pass for your domain.
