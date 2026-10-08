# Zammad for Helpdesk Integration — manual setup guide

**Zammad for Helpdesk Integration** (`helpdesk_zammad`) is a platform plugin for the
[Helpdesk Integration](https://www.drupal.org/project/helpdesk_integration) framework
that connects your Drupal helpdesk to **[Zammad](https://zammad.org)**. With it
enabled, issues and comments raised on your Drupal site are synced to **Zammad
tickets**, and you can optionally embed Zammad's **chat widget** on your site.

It is not a standalone module — it depends on Helpdesk Integration and adds "Zammad"
as one of the platforms you can choose when you create an integration there. The
user‑facing helpdesk experience (the `/helpdesk` page, the issue content, the
permissions) all comes from the framework; this module supplies the Zammad
connection and the two‑way sync.

What the sync does, in plain terms:

- **Create ticket** — a Drupal helpdesk issue opens a Zammad ticket, filed on behalf
  of the issue's owner.
- **Add comment** — a Drupal comment is appended to the matching Zammad ticket as an
  article.
- **Resolve** — resolving a Drupal issue sets the ticket to your chosen "closed"
  state in Zammad.
- **Sync users** — the issue owner is upserted as a Zammad customer so tickets are
  attributed to the right person.
- **Pull tickets** — Zammad tickets (with their articles and attachments) are pulled
  back into Drupal, optionally only those updated since a given date for incremental
  sync.

You can run **multiple Zammad instances**, each as its own helpdesk integration.

A note on security and credentials: connecting to Zammad requires the instance
**URL** and an **API token**. Be aware that this module stores the API token as
**plain text** on the integration's configuration entity — it is an ordinary text
field, not a password field and not a Key‑module reference — so treat that
configuration as sensitive and restrict who can edit helpdesk integrations. On the
positive side, the module does **not** disable TLS certificate verification (it
leaves the underlying HTTP client's defaults in place), it ships **no routes,
permissions, or forms of its own** (so there is no anonymous ticket‑create endpoint
here — ticket creation is a server‑side action driven by the framework), and the chat
widget script is loaded from the admin‑configured instance URL.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Helpdesk Integration.
2. [Configuration](configuration/index.md) — create a Zammad integration, enter its
   URL and API token, and optionally enable the chat widget.

## Where it lives in the admin menu

There is no separate settings page for this module. You configure it as a Zammad
integration inside Helpdesk Integration, at **Configuration → Web services →
Helpdesk** (`/admin/config/services/helpdesk`).
