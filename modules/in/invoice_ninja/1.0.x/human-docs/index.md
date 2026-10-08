# Invoice Ninja — manual setup guide

**Invoice Ninja** (`invoice_ninja`) connects your Drupal site to an
[Invoice Ninja](https://invoiceninja.com) account — either the hosted SaaS
service or your own self‑hosted instance — and keeps records in sync between the
two. It pushes Drupal users and clients, VAT rates, and invoices *out* to
Invoice Ninja through Invoice Ninja's official PHP SDK, so your billing system
mirrors what happens on your site.

Under the hood the module provides a set of "synchronizer" services (one each for
users/clients, VAT rates, and invoices). Each keeps a small local map of "this
Drupal record ↔ that Invoice Ninja record" plus a last‑sync timestamp, so the
first sync *creates* the remote record and every sync after that *updates* it —
you don't end up with duplicates. Synchronization can be triggered three ways:
by entity **actions** you run from Views Bulk Operations or ECA (*Sync Client*,
*Sync Invoice*, *Sync VAT*), by an **ECA condition** (*SyncStatus*) that reports
whether a record is already synced, and by a **Drush command** that batch‑syncs
users.

Setup is a single admin form where you enter your Invoice Ninja URL and API
token. One important caveat to know up front: this module stores the API token
and the admin password **in plain text** in its configuration — see the
Configuration page for how to handle that safely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its required
   Invoice Ninja SDK with Composer, then enable it.
2. [Configuration](configuration/index.md) — the connection settings form, the
   permissions, and how to keep your API token out of shared config.

## Where it lives in the admin menu

The connection settings live at **Configuration → System → Invoice Ninja**
(`/admin/config/system/invoice_ninja`, route `invoice_ninja.settings`), gated by
the *Administer invoice_ninja configuration* permission.
