# Exact Online — manual setup guide

**Exact Online** (`exact_online`) connects your Drupal site to
[Exact Online](https://www.exact.com/), the accounting/ERP platform, using the
`picqer/exact-php-client` library as the middleware that talks to the Exact Online API
over OAuth.

It is important to understand what this module does and does not do. It takes care of
**setting up and maintaining the API connection** — the OAuth handshake, storing the
tokens, and showing you the connection status. It does **not** include any
ready-made synchronization of data between Drupal and Exact Online. That
synchronization logic is always custom code, because every Exact Online implementation
is shaped by the specific business it serves. Think of this module as the reliable
foundation you build your own integration on top of.

What you get out of the box:

- A **dashboard** showing the current connection status.
- A **settings form** for your Exact Online API connection (Client ID and Client
  Secret).
- A **log view** of entries related to the module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (it pulls
   in the picqer/exact-php-client library) and enable it.
2. [Configuration](configuration/index.md) — create an Exact Online app, enter your
   Client ID and Secret, and complete the OAuth connection.

## Where it lives in the admin menu

The module's settings form is at **Configuration → Web services → Exact Online →
Settings** (`/admin/config/services/exact-online/settings`), with the connection
dashboard and log view under the same **Exact Online** section.

## How to use it

1. Create an Exact Online application to obtain a **Client ID** and **Client Secret**.
2. Enter those on the settings form and complete the OAuth connection — see
   [Configuration](configuration/index.md).
3. Watch the **dashboard** to confirm the connection is live, and check the **log view**
   if something looks wrong.
4. Build your own module/code on top of the connection to sync the specific data
   (invoices, customers, etc.) your business needs.

> **Release status.** This project is a young pre-release (1.0.0-alpha1) and is **not
> covered by Drupal's security advisory policy**. Evaluate it accordingly before relying
> on it for a production site.
