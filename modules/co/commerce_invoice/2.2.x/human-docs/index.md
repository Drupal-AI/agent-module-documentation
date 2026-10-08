# Commerce Invoice — manual setup guide

**Commerce Invoice** (`commerce_invoice`) adds proper invoicing to Drupal
Commerce. It defines an **Invoice** content entity and generates numbered,
workflow-driven invoices — and credit memos — from your Commerce orders. Each
invoice can be rendered as a printable PDF (via the Entity Print module) and
emailed to the customer as a confirmation with the PDF attached.

Two invoice types ship out of the box: **Invoice** (`default`) and **Credit memo**
(`credit_memo`). Each is tied to a *number pattern* that produces sequential,
formatted invoice numbers, and to a workflow that moves an invoice through states
like draft → pending → paid (with refund and cancel paths). An invoice type also
carries presentation and billing settings — a logo, footer text, payment terms,
due days — and controls whether a confirmation email is sent.

Invoices can be created three ways: automatically when an order is placed or fully
paid (configured per order type), manually by staff from the order's *Invoices*
tab, or programmatically in code through the invoice generator service. Because
the Invoice is a real fieldable entity, you can add custom fields, translate
invoices for a multilingual store, and expose customers' own invoices to them
under their account.

This is a developer-and-store-builder module that sits on top of Drupal Commerce,
so it has a fair number of dependencies (Commerce, number patterns, Entity Print,
and more). This guide is written for a **human** setting it up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, the
   dependencies it pulls in, and enable the module.
2. [Configuration](configuration/index.md) — invoice types, number patterns and
   workflow, automatic generation per order type, and permissions.

## Where it lives in the admin menu

Invoice types are managed under **Commerce → Configuration → Invoice types**
(`/admin/commerce/config/invoice-types`), and invoice item types at
`/admin/commerce/config/invoices/invoice-item-types`. Automatic generation is
configured on each **order type** at
`/admin/commerce/config/order-types/<type>/edit`. Individual invoices appear on
the *Invoices* and *Credit memos* tabs of each order.
