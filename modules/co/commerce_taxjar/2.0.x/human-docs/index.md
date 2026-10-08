# Commerce TaxJar — manual setup guide

**Commerce TaxJar** (`commerce_taxjar`) connects Drupal Commerce to the
**TaxJar** platform for automated US sales‑tax calculation. Instead of building
tax rules by hand, your store sends each order to TaxJar's API and gets back an
accurate rate — with breakdowns by state, county, and local jurisdiction — and
TaxJar can also track and file your collected sales tax.

It is designed to be quick to set up (TaxJar advertises "up and running in under
five minutes") and it integrates with **Commerce Shipping** and **Commerce
Discount** so tax is handled correctly for taxable shipping and for discounted
orders. It depends on Drupal Commerce — specifically the Order, Store, Tax, and
Payment pieces — and Commerce Shipping and Commerce Discount are supported but not
required.

Because tax is calculated by an external service, two things matter for security.
First, the module **sends order data — addresses and amounts — to TaxJar** to
compute tax; that egress is inherent to the service. Second, it authenticates with
a **TaxJar API token**, which is a credential: you enter it on the TaxJar tax-type
form and it is kept in that tax type's Commerce configuration, so treat any
configuration export of the site as sensitive and serve the site over HTTPS. See
[Configuration](configuration/index.md) for the setup steps.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Commerce.
2. [Configuration](configuration/index.md) — connect your TaxJar API token,
   configure nexus, and store credentials securely.

## Where it lives in the admin menu

TaxJar is set up as a **tax type** under **Commerce → Configuration → Tax types**
(`/admin/commerce/config/tax-types`). See
[Configuration](configuration/index.md).
