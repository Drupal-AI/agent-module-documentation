# KeyCRM — manual setup guide

**KeyCRM** (`keycrm`) connects a **Drupal Commerce** store to
[KeyCRM](https://keycrm.app/), a modern Ukrainian CRM and order‑management
platform for e‑commerce. Once configured, new orders placed on your Drupal store
are sent to your KeyCRM workspace automatically, and order statuses are kept in
step between the two systems — so your sales team can manage fulfilment, clients,
and communication in KeyCRM without re‑keying anything.

It's aimed at small to medium online stores that already run on Drupal Commerce
and want a single place to handle sales, customer contact, and order tracking.
Under the hood it maps a customer's details (name, email, phone) into KeyCRM
leads or clients, sends new orders on checkout completion, and logs the API's
responses so you can see when something goes wrong.

The module talks to KeyCRM over its API using an **API token** you generate in
your KeyCRM account. That token is a secret: store it in an environment variable
rather than typing it into a form that gets exported to configuration or
committed to git (see [Configuration](configuration/index.md)). Note that KeyCRM
is a hosted third‑party service, so order and customer data leaves your site to
reach it — disclose that in your privacy policy as appropriate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   Drupal Commerce dependencies, and enable the module.
2. [Configuration](configuration/index.md) — enter your KeyCRM API token and
   connection settings, and store the token securely.

## Where it lives in the admin menu

After you enable the module, its settings live at **Configuration → Web services
→ KeyCRM** (`/admin/config/services/keycrm`). That is where you paste (or, better,
reference) your KeyCRM API token and confirm the connection. New orders flow to
KeyCRM automatically once the token is in place.

## How to use it

There is very little day‑to‑day interaction: once the token is configured,
placing an order on the store sends it to KeyCRM at checkout completion, and
status changes sync from there. You extend the behaviour — custom field mapping,
extra events — in code via event subscribers or hooks; this version does not
offer a field‑mapping UI.
