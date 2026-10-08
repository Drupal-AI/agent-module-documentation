# Resend API — manual setup guide

**Resend API** (`resend_api`) sends your site's email through
[Resend](https://resend.com/), a transactional email delivery service, instead of
the local mail server. It plugs into Drupal through the **Mail System** module as a
mail backend, so once it is set up your site's outgoing messages — account
notifications, contact form replies, and so on — are handed to Resend's API for
delivery.

Setup is short: add your Resend **API key** on the module's settings page, then
point Mail System at the Resend backend. One requirement to plan for: the domain of
your site's email address (from **Basic site settings**) must be verified in your
Resend account. For quick testing you can use any `@resend.dev` address as your
site email without verifying a domain.

> **Handling the API key and email data.** This module authenticates to Resend with
> a secret API key and sends message content and recipient addresses (personal
> data) to Resend over the internet. Treat the key as a secret — never hard-code or
> commit it. Store it in an environment variable and reference it through a **Key**
> entity, as described in [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Mail System
   dependency) with Composer and enable it.
2. [Configuration](configuration/index.md) — add your Resend API key, store it
   securely, and select the Resend backend in Mail System.

## Where it lives in the admin menu

The module's settings form is at **Configuration → System → Resend API**
(`/admin/config/system/resend-api`). You also configure which backend sends mail at
**Configuration → System → Mail System** (`/admin/config/system/mailsystem`).
