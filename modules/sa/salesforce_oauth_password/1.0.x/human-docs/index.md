# Salesforce OAuth Password Provider — manual setup guide

**Salesforce OAuth Password Provider** (`salesforce_oauth_password`) adds a
**password-based** authentication option to the **Salesforce Suite** — the OAuth 2.0
username-password grant. Drupal authenticates to Salesforce using a Salesforce
user's **username and password** (with the security token appended), together with a
connected app's consumer key and consumer secret.

It exists for the cases where the username-password flow is the only option
available. Be aware, though, that both Salesforce and this module's own
documentation steer you away from it: it passes credentials back and forth and is
**less secure**, and Salesforce is deprecating and restricting it in favour of the
JWT bearer and client-credentials flows. Use it only where there is a high degree of
trust between the parties, it is a first-party app, and no better grant type is
available — and even then with a dedicated, least-privilege integration user.

The module only provides the auth plugin; it has no day-to-day features and no
access-control role. You configure it once by adding an auth provider on the
Salesforce Suite's authorization screen. It depends on the **Salesforce Suite**,
has no submodules, and needs no third-party PHP libraries.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — Composer, the Salesforce Suite
   dependency, and enabling the module.
2. [Configuration](configuration/index.md) — adding a password auth provider on the
   Salesforce authorization screen.

## Where it lives in the admin menu

It plugs into the Salesforce Suite's own authorization configuration, at
**Configuration → Salesforce → Salesforce Authorization**. Once enabled,
"Salesforce OAuth Password" becomes an available provider type there.

## Security — please read this

This flow **stores and uses a Salesforce user's password** (with the security token
appended). Treat every part of the credential as a secret: keep the **username,
password, security token, consumer key and consumer secret** out of exported
configuration and out of version control (source them from environment variables or
a Key entity), and always operate over HTTPS. Use a **dedicated integration user
with least-privilege** Salesforce permissions, never a real person's admin account.
And, wherever you can, **prefer the JWT bearer or client-credentials flows** over
this one — Salesforce is phasing the password flow out.
