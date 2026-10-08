# Mobile ID — manual setup guide

**Mobile ID** (`mobileid`) authenticates users through a **Mobile ID** service —
an identity technology that uses a person's unique mobile phone number as the means
of authorisation and verification, with the phone acting as a secure token. Instead
of usernames, passwords, or codes typed from an SMS or email, the user enters their
number and confirms a push prompt (or enters an authorisation code) on their phone.
It's positioned as a fast, modern alternative to SMS/email verification that
doesn't require users to register or install a special app.

Under the hood the module runs the authentication as a live flow: it exposes a
**JWKS endpoint** (which publishes public keys — public by design) and a
**server-sent-events (SSE) stream** keyed by an unguessable per-request UUID, so the
browser can wait for the user to approve the login on their phone. It supports
Drupal 10.3+ and 11. Note this release is an early (beta) version and is marked as
*not covered* by Drupal's security advisory policy, so evaluate it accordingly
before production use.

> **Credentials are secrets.** To talk to the Mobile ID service you'll hold
> provider credentials — store them in environment variables (env-backed), never
> hard-coded or committed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connect to your Mobile ID provider and
   store its credentials securely.

## How to use it

Once connected to a Mobile ID provider, users authenticate by entering their mobile
number and approving the login on their phone. See
[Configuration](configuration/index.md) for the provider setup.
