# Letsencrypt — manual setup guide

**Letsencrypt** (`letsencrypt`) is an integrated **ACME client** for obtaining a
free **Let's Encrypt** SSL/TLS certificate from within Drupal. It wraps the
`yourivw/LEClient` PHP library (an ACME v2 client) to make certificate issuance
and renewal an easy, code‑driven task: point it at a domain, prove you control
that domain, and receive a certificate. It handles the ACME **HTTP‑01 challenge**
by writing challenge files under `.well-known/acme-challenge`, which Let's Encrypt
then fetches to verify domain control.

To use it you need access to the web server (or DNS management) so the domain can
be verified as accessible and owned by you. There is a settings/demo page, and
the module also exposes a service you can call from code — for example
`\Drupal::service('letsencrypt')->sign($domain)` to issue a certificate and
`->read($domain)` to read it back. More advanced setups (a custom verification
callback, and wildcard certificates via a DNS callback such as AWS Route 53) are
documented in the module's README.

Automating TLS is a **security‑positive** thing to do — it means encrypted
connections without manual certificate juggling — but the key material it handles
must be treated carefully:

- The module needs **filesystem write access** to serve the challenge files and to
  store issued certificates.
- It manages the **ACME account key and the issued private keys**. These must be
  stored so that only the server can read them and they are **never web‑exposed**.
- The admin configuration should be **restricted to trusted administrators**.

The module has no runtime access‑control role of its own; its job is issuing and
renewing certificates.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings page, issuing a
   certificate, and handling the key material safely.

## Where it lives in the admin menu

Once enabled, the settings and demo page is at **Configuration → System →
Letsencrypt** (`/admin/config/system/letsencrypt`), gated by the **Administer
site configuration** permission.
