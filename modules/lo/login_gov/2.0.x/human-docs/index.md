# Login.gov OpenID Connect — manual setup guide

**Login.gov OpenID Connect** (`login_gov`) lets a US federal site authenticate
members of the public through **Login.gov**, the government's shared single
sign‑on. Login.gov is one account per person, with the identity proofing and
multi‑factor authentication done once and reused across agencies. For a federal
site that means it does **not** run its own registration and does **not** store its
own passwords — it inherits an assurance level it could not economically build on
its own. Agencies are generally directed toward Login.gov rather than choosing it.

This module supplies the **provider plugin** for the OpenID Connect module — it
plugs Login.gov in as an OIDC/OAuth 2.0 identity provider, including support for
requiring MFA or PIV/CAC. It requires the **OpenID Connect** module (version 3.0
or later) and, notably, the **Asymmetric Keys** module (`key_asymmetric`, 1.2.0+).

That second dependency is the tell that the integration is done properly. Login.gov
requires **private‑key JWT** client authentication rather than a shared client
secret: your site signs its token requests with a **private key** whose public half
is registered with Login.gov. Operationally that changes the work — there is a key
pair to generate, register, protect, and eventually rotate, and the private key
belongs in a **Key entity** backed by an environment variable or a KMS, never
pasted into configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its OpenID Connect / Asymmetric Keys dependencies.
2. [Configuration](configuration/index.md) — generate and store the signing key,
   register with Login.gov, and set up the OpenID Connect client.

## Where it lives in the admin menu

Login.gov is configured as a **client of the OpenID Connect module**, so its
settings live alongside the other OIDC clients under **Configuration → People →
OpenID Connect** (`/admin/config/services/openid-connect`). The signing key is
managed as a **Key entity** at **Configuration → System → Keys**
(`/admin/config/system/keys`). See [Configuration](configuration/index.md) for the
full flow.

## Three things to plan before you start

1. **IAL and AAL levels** — the identity‑proofing and authentication‑assurance
   levels you request — are a **programme policy decision** with real consequences
   for who can complete registration. They belong to the programme, not the Drupal
   team.
2. **Account linking.** Decide what happens when a Login.gov identity arrives whose
   email matches an existing local account. That is a **security** question, not a
   convenience one.
3. **Sandbox and production are separate registrations.** A working integration in
   the Login.gov sandbox proves nothing about production, and vice versa. You will
   need a sandbox account with the Login.gov sandbox environment to get started.
