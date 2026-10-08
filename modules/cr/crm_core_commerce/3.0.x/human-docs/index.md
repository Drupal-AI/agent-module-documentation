# CRM Core Commerce — manual setup guide

**CRM Core Commerce** (`crm_core_commerce`) bridges Drupal Commerce and CRM Core:
when a customer places an order, it creates or updates the matching CRM Core contact
so your CRM records stay in sync with what happens in your store. In practice this
ties purchases to contact profiles automatically — after checkout, the buyer's
details flow into a CRM Core contact without anyone re-keying them.

Mechanically, the module listens for the order-placed event
(`commerce_order.place.post_transition`) and, when it fires, creates or updates the
corresponding CRM Core individual contact. There is a small amount of setup: after
enabling the module you tell it which CRM Core individual bundle new contacts should
use (see [Configuration](configuration/index.md)). Developers can go further and
alter the data written to the contact, either through a hook
(`hook_crm_core_individual_data_alter()`) or by extending the module's mapper
service.

This is a pure integration module with no access-control role of its own. It builds
on **CRM Core** (including the contact submodule) and **Commerce**'s order module,
and supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside CRM Core and Commerce.
2. [Configuration](configuration/index.md) — choose the CRM Core contact bundle that
   orders map to.

## Where it lives in the admin menu

Its settings are at **Configuration → CRM Core → Commerce Settings**
(`/admin/config/crm-core/commerce/settings`).
