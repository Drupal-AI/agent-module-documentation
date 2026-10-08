# MKC B2B — manual setup guide

**MKC B2B** (`mkc_b2b`) brings enterprise business-to-business commerce to a
**MonkeysCommerce** store: company accounts and corporate hierarchies, purchase
orders, request-for-quote (RFQ) workflows, contract and tiered pricing, approval
chains, quick/bulk ordering, one-click reorder, and **cXML/OCI PunchOut**
integration with e-procurement platforms such as SAP Ariba and Coupa.

It adds a rich set of entities — **Company** (with billing info, tax-exemption
status and credit limits), **CompanyUser** (mapping Drupal users to companies with
buyer/manager/admin roles), **Quote**, **PurchaseOrder**, **ContractPriceList** and
**ApprovalPolicy** — and services that resolve contract pricing at cart time, run
multi-level approvals against spending thresholds, drive the quote lifecycle, and
manage PunchOut sessions. Buyers get a company portal (company profile, users,
quotes), and there's a full REST API plus PunchOut endpoints.

Because it touches pricing, checkout, cart, orders, payment and approvals, it
depends on a broad slice of the MonkeysCommerce suite — `mkc_core`, `mkc_catalog`,
`mkc_cart`, `mkc_order`, `mkc_checkout`, `mkc_payment` and `mkc_pricing` — and
targets Drupal 11.3+ on PHP 8.2+.

> **Security — set the PunchOut shared secret.** The PunchOut endpoints
> (`/mkc/punchout/cxml` and `/mkc/punchout/oci`) are publicly routed and verify the
> incoming **SharedSecret** only when one has been configured. If you leave it
> **unset (the default), that verification is skipped**, which allows anonymous
> PunchOut sessions. If you use PunchOut at all, configure the shared secret before
> going live (and store it as a secret — see [Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module on your MonkeysCommerce store.
2. [Configuration](configuration/index.md) — companies, pricing, approvals, and the
   PunchOut shared secret.

## Where it lives in the admin menu

Once enabled, the module's screens sit under **Commerce → B2B**:

- `/admin/commerce/b2b` — B2B dashboard overview.
- `/admin/commerce/b2b/settings` — module configuration (including PunchOut).

Buyers use the customer portal at `/account/company`, `/account/company/quotes` and
`/account/company/quotes/{id}`.
