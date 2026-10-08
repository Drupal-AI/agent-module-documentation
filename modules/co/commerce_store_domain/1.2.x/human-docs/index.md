# Commerce Store Domain — manual setup guide

**Commerce Store Domain** (`commerce_store_domain`) lets one Drupal Commerce site
run several stores, each on its own domain, and picks the **current store**
automatically from the domain the visitor is on. Serve `shopa.com` from store A
and `shopb.com` from store B out of the same codebase, with each domain's cart
kept separate.

It does this by adding a **Domain** field to the Commerce store entity and slotting
a store resolver into Commerce's resolver chain. On every request the resolver
reads the request's hostname and returns the store whose Domain field matches — so
the active store simply follows the domain. The field is multi‑value, so you can
point several hostnames or subdomains (`eu.example.com`, `us.example.com`, aliases)
at a single store.

If you also run the contrib **Domain** module, Commerce Store Domain integrates
with it: instead of matching raw hostnames, it resolves the store from Domain's
active‑domain negotiation via a reference field, and it swaps in a cart provider
that scopes carts to the current store — so a shopper's cart on one domain never
leaks to another.

The module is a thin, code‑only integration layer. It has **no admin settings
page**, no permissions, and no configuration object — you simply set each store's
domain(s) on the store edit form. It builds on **Drupal Commerce** (`commerce` and
`commerce_store`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — assign a domain to each store, and
   what changes when the Domain module is enabled.

## Where it lives in the admin menu

There is no dedicated settings page. You configure the module on each store's edit
form at **Commerce → Configuration → Stores → Stores**
(`/admin/commerce/config/stores`), where the new **Domain** field appears.

## How to use it

1. Create your stores as usual under **Commerce → Configuration → Stores**.
2. Edit each store and fill in its **Domain** field with the hostname(s) it should
   answer on.
3. Point those domains' DNS and your web server / virtual hosts at this Drupal
   site.

That's it — the current store now follows the visitor's domain. See
[Configuration](configuration/index.md) for details, including the Domain‑module
integration.
