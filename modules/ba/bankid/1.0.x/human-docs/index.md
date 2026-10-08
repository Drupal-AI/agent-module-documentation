# BankID — manual setup guide

**BankID** (`bankid`) lets people log in to (or sign in on) your Drupal site with
**BankID**, the Swedish national e-ID. The flow is the familiar one: the site
starts an authentication order, the user approves it in the BankID app on their
phone, and the server collects the verified identity. It supports Drupal 10 and
11.

The module is built on the right foundations. It maps the verified BankID
identity to a Drupal user through the **ExternalAuth** service — Drupal's trusted
mechanism for external logins — and it stores the BankID API credentials through
the **Key** module rather than in plain configuration. Under the hood, your site
starts an order at `/api/bankid/authenticate` (a server-side call to BankID's
mutual-TLS API), and `/api/bankid/collect/{orderRef}` polls BankID's `collect`
API for the verified result, whose personal number is turned into the
ExternalAuth identity used to log the user in or register them.

Because this is national-identity authentication, a few things are
**security-critical** and must be right for your deployment:

- The BankID **client certificate and credentials** authenticate *your* merchant
  to BankID. Keep them secret — in the environment and the Key module, never in
  committed config or a database dump.
- The authentication **order must be bound to the session that started it**, so
  one user cannot complete another user's `orderRef` and hijack their login.
- Serve **everything over HTTPS**.

It depends on the **Key** and **ExternalAuth** modules and layers on top of core
authentication.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in Key and
   ExternalAuth, and handle the certificate securely.
2. [Configuration](configuration/index.md) — store the BankID certificate as a
   Key and connect it to the module.

## How it works, briefly

The site calls BankID to start an order, the user approves it in the BankID app,
and the server polls `collect` until BankID returns the verified identity. That
identity — via ExternalAuth — logs the matching Drupal user in (or creates one).
Everything sensitive happens server-side against BankID's mTLS API.
