# Public Key Credential Source — manual setup guide

**Public Key Credential Source** (`public_key_credential_source`) is a
building‑block module for WebAuthn (passkey / security‑key) authentication. It
provides a **"Public Key Credential Source" entity type** — a place to store the
records that are created when a user registers a passkey or hardware security
key. Each record holds the credential's id, its **public key**, the sign
counter, and the user handle: exactly the data a site needs to later verify that
same authenticator when the user signs in.

It's important to understand what this module is and isn't. It is **plumbing**,
not a full login system. On its own it doesn't add a passwordless login form or a
two‑factor prompt — it stores credentials for *other* modules to use. The project
points to **Decoupled Passkeys** as an example of a module that builds a real
WebAuthn flow on top of this store. This is an **experimental / alpha** module
derived from the original WebAuthn module's credential entity.

On the security side, WebAuthn stores only the **public** key, not a secret — so
the store itself is not a password vault. But these records still gate a user's
authentication factor, so you should protect access to them (that's what the
module's permission is for) and rely on the **WebAuthn Framework** to verify
signatures and enforce the sign counter, which is how cloned‑authenticator
attacks are detected.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## Where it lives in the admin menu

This module has **no settings form of its own**. It defines a storage entity type
that other WebAuthn modules read and write; there is nothing to configure through
a dedicated admin page. Its one user‑facing control is a **permission** that
governs access to the stored credential entities — set it at **People →
Permissions** (`/admin/people/permissions`), and grant it only to trusted roles.

## How to use it

You don't interact with this module directly day to day. Instead:

1. Install and enable it (see [Installation](installation/index.md)) so the
   credential‑source entity type exists.
2. Install a WebAuthn/passkey module that uses this store to register and verify
   credentials — for example **Decoupled Passkeys** — and follow that module's
   setup.
3. Restrict the module's permission to trusted administrative roles so the stored
   credential records can't be read or manipulated by ordinary users.
