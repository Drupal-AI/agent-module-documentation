# Decoupled Passkeys — manual setup guide

**Decoupled Passkeys** (`decoupled_passkeys`) adds **passkey (WebAuthn)
authentication** to a decoupled (headless) Drupal site. Passkeys let people sign in
with a device biometric (fingerprint, face) or a hardware security key instead of a
password. This module exposes the WebAuthn registration and login ceremonies over
**JSON‑RPC**, so a headless front end can drive them and log users in with passkeys.

It is an **experimental** module (currently in an alpha), and the maintainer is
clear that **custom code will be required** to wire it into a real front end — it
provides the JSON‑RPC endpoints and the plumbing, not a turnkey login screen. It
builds on three other modules: **JSON‑RPC** (`jsonrpc`), **Public Key Credential
Source** (`public_key_credential_source`), and the **WebAuthn Framework**
(`webauthn_framework`, using the well‑tested `web-auth` PHP library, version 4). It
provides its own permissions and layers on top of core authentication.

This is **security‑critical** territory, so a few points matter. The actual
WebAuthn assertion verification — checking the challenge, the origin and
relying‑party (RP) ID, the signature, and user presence/verification — is performed
by the **WebAuthn Framework**, not by this module. That means you must make sure
the **RP‑ID, origin, and user‑verification** settings are configured correctly for
your domain; a misconfigured origin or RP‑ID check weakens the whole guarantee.
Serve everything over **HTTPS**, ensure the JSON‑RPC endpoints require the correct
permission, and never trust a client that merely *claims* to be authenticated
without the server‑side ceremony having succeeded.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with its three
   dependencies), enable it, and assign its permissions.

This module has **no dedicated settings form** in its own admin UI — it is
configured through its dependencies (particularly the WebAuthn Framework's RP‑ID /
origin settings), its JSON‑RPC endpoints, its permissions, and the custom
integration code your front end supplies. The project README is the authoritative
reference for wiring it up. Because there is no settings form of its own, there is
no separate Configuration section in this guide.

## Where it lives in the admin menu

Decoupled Passkeys adds no standalone configuration page. You manage access to its
JSON‑RPC endpoints via **People → Permissions** (`/admin/people/permissions`), and
the WebAuthn relying‑party settings (RP‑ID, origin, user verification) are
configured through the **WebAuthn Framework** module. Consult the module's README
for the current endpoint and setup details, since the module is experimental and
evolving.
