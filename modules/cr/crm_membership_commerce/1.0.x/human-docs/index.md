# CRM Membership Commerce — manual setup guide

**CRM Membership Commerce** (`crm_membership_commerce`) connects Drupal Commerce to the
[CRM Membership](https://www.drupal.org/project/crm_membership) module, so that buying a
"membership" product automatically creates or renews a CRM membership for the person who
bought it. It turns your storefront into a membership sign-up and renewal channel without
any manual data entry.

When an order is placed, an event subscriber inspects each order item. If a purchased
product variation carries a reference to a **CRM Membership Type**, the module resolves
the target contact (from a contact reference on the variation, or falling back to the
membership type's default target), resolves the buyer's CRM contact from the order's
customer (creating a user-to-contact mapping if one does not exist yet), and then either
renews an existing active or expired membership of that type or creates and activates a
brand-new one. Because it discovers the reference fields dynamically, **any** product
variation bundle can sell memberships simply by having the right reference field — there
are no hardcoded field names or bundle types. To help you get started it also ships a
preconfigured membership product variation type, order item type, and order type.

There is an important operational caveat. The membership is granted on the order's
**place** transition (checkout completion), not on a verified "payment received" event.
With payment gateways where an order can be placed before the payment is actually
captured, a membership may be granted before funds are confirmed — so factor your
gateway's behavior into how you configure checkout. Anonymous orders with no customer are
skipped.

Setup is entirely code and configuration — the module has **no settings form, routes, or
permissions of its own**. You configure it by setting up membership types in CRM
Membership and adding the right reference fields to your membership product variations, as
described under "How to use it" below. It requires **CRM Membership**, **Commerce
Product**, and **Commerce Order**, and needs Drupal 11.1 or newer.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it alongside CRM Membership and Commerce.

There is **no configuration page** for this module — it has no settings form. All setup
happens in CRM Membership and on your Commerce product variations, described in "How to
use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You configure it through **Structure → CRM →
Membership Types** (CRM Membership) and your Commerce product variation types under
**Commerce → Configuration → Product variation types**.

## How to use it

1. **Create a CRM Membership Type** at **Administration → Structure → CRM → Membership
   Types**. Configure its term plugin (for example a rolling one-year duration) and, if
   appropriate, set a default target contact — the organization members join.
2. **Set up a product variation.** The module ships a **membership** product variation
   type with the required fields already configured, but you can use any variation type.
   The key requirement is an entity-reference field targeting **CRM Membership Type**.
   Optionally, add an entity-reference field targeting **CRM Contact** to override the
   target contact per product.
3. **Create a Commerce product** using the membership variation type and select the
   desired CRM Membership Type on the variation.
4. **Checkout.** When a customer completes checkout and the order is placed, the module
   automatically creates or renews a CRM membership for that customer based on the
   purchased variation. If it cannot resolve the membership type or contact, it logs a
   warning — check the site logs (`/admin/reports/dblog`) to trace grants and problems.
