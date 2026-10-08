# Iplicit API — manual setup guide

**Iplicit API** (`iplicit_api`) connects your Drupal site to
[Iplicit](https://www.iplicit.com/), a cloud accounting/ERP system, by providing a
ready-made **authenticated HTTP client** for Iplicit's REST API. It handles the
tedious, easy-to-get-wrong parts for you: logging in, caching the short-lived
session token, sending the mandatory `Domain` header on every request, retrying
after a rejected token, and mapping errors to typed exceptions.

It is a **library for other modules, not a finished integration**. Out of the box
it adds no content types, no fields, and syncs nothing on its own. If you want to
push Commerce orders or invoices into Iplicit, that logic belongs in a separate
module that depends on this one and calls its client. What you *do* get here is one
settings page to configure the connection, a set of services, and 28 generated
resource classes covering the Iplicit API (contacts, customers, products, prices,
sale orders, invoices, payments, and more).

Secrets are handled carefully: the API key is stored through the **Key** module,
and only the key's *ID* is saved in configuration — so `drush config:export` never
writes the secret into `config/sync`. The session token is cached (capped at 30
minutes) and never written to the log.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the PHP and
   Key requirements, and enable the module.
2. [Configuration](configuration/index.md) — store the API key securely, fill in
   the connection settings, and run "Test connection".

## Where it lives in the admin menu

The connection settings form is at **Configuration → Web services → Iplicit API**
(`/admin/config/services/iplicit`), behind the restricted **Administer Iplicit
API** permission.

## How to use it

For a site builder, "using" this module means configuring the connection (see
[Configuration](configuration/index.md)) and then installing or writing a consumer
module that depends on it. Developers inject the `iplicit_api.client` service (or a
resource class wired up in their own module) and call it — the client is already
authenticated and maps errors for them.
