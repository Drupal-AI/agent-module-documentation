# Laposta Webform — manual setup guide

**Laposta Webform** (`laposta_webform`) connects **Drupal Webform** to
**Laposta**, the Dutch email‑marketing service. It adds a Webform **handler** that
subscribes form submitters to your Laposta mailing lists — so you keep full
control over the form's design in Webform while sign‑ups flow automatically to
Laposta. Its standout feature is **dynamic list selection**: visitors can choose
which list(s) to join, using dedicated Laposta list‑select and list‑checkbox form
elements.

The handler is flexible. You can subscribe people to a **fixed list** or let them
pick from **multiple lists** (dropdown or checkboxes), **filter** which lists
visitors are allowed to see, and map form fields to Laposta fields — with
auto‑mapping by field name and support for all Laposta field types (text, numeric,
date, single select, multiple select). It also handles required‑field validation
before subscribing and supports an **opt‑in field** for GDPR‑style consent. It
depends on the **Webform** module and supports Drupal 10.3+ and 11.

One responsibility comes with it: the **Laposta API key** is a secret, configured
by an administrator and stored via an environment variable — never committed to
version control. And because submissions send personal data to Laposta, use the
opt‑in support and your form's wording to capture proper consent.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — store the API key safely and add the
   Laposta handler to a webform.

## Where it lives in the admin menu

You set the Laposta API key on the module's admin settings form, then configure
the integration **per webform** by adding the Laposta handler under **Structure →
Webforms → *(your form)* → Settings → Emails / Handlers**. See
[Configuration](configuration/index.md).
