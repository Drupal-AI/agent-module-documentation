# InvoiceXpress API — manual setup guide

**InvoiceXpress API** (`invoicexpress_api`) integrates the certified Portuguese
invoicing service [InvoiceXpress](https://invoicexpress.com) with your Drupal
site. It lets Drupal create and manage invoices, estimates, and clients in your
InvoiceXpress account programmatically — automating invoice generation from
orders or other site actions and keeping your invoicing compliant with local
fiscal requirements.

The module exposes four services your custom code (or a Drupal Commerce
integration) can call: `invoicexpress_api.invoices`,
`invoicexpress_api.estimates`, `invoicexpress_api.clients`, and
`invoicexpress_api.sequences`. There is no ready‑made end‑user screen; this is an
integration layer that developers wire into your invoicing workflow. It also
provides its own permission.

To use it you need a direct contract with InvoiceXpress and an API key from your
InvoiceXpress dashboard. Because that key authenticates billing operations and
the data exchanged is financial and fiscal personal data, store the key as a
secret and handle the data according to your privacy and fiscal obligations — see
the Configuration page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — entering your InvoiceXpress API
   credentials and storing them safely.

## Where it lives in the admin menu

The settings page is at **Configuration → Web services → InvoiceXpress API**
(`/admin/config/services/invoicexpress_api`). See
[Configuration](configuration/index.md) for what to enter there.

## How to use it

Once your credentials are saved, the integration is driven from code. Inject one
of the four services — for example `invoicexpress_api.invoices` to create and
manage invoices, or `invoicexpress_api.clients` to manage client records — and
call it from your own module, an event subscriber, or a Drupal Commerce
integration to generate invoices when orders or registrations occur.
