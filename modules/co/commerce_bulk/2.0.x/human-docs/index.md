# Commerce Bulk — manual setup guide

**Commerce Bulk** (`commerce_bulk`) speeds up building and maintaining large
Drupal Commerce catalogs by **mass‑creating and editing** product variations,
attribute values, and taxonomy terms. Instead of adding variations one at a time,
you can generate every combination of a product's attributes in a single
operation — with unique SKUs and a default price — and then bulk‑adjust prices,
statuses, titles, and more. It depends on Commerce Order plus core's **Action**
and **Taxonomy** modules.

At its heart is a variations‑creator service that computes the full Cartesian
product of a variation type's attribute options, subtracts combinations already in
use, and creates all the missing variations at once (with duplicate detection).
Around that, the module adds a batch of bulk **Action** plugins exposed on a
per‑product **Variations** tab (`/product/{id}/variations`) and on the
product‑attributes, taxonomy, and orders pages. A dedicated SKU field widget lets
you control the SKU prefix/suffix pattern, toggle a unique‑id component, and cap
how many variations are created per run.

There's a lot you can do without leaving the admin UI: generate all variations (or
a capped subset), auto‑assign unique SKUs, duplicate or delete variations in bulk,
set or adjust prices, change published status, regenerate titles or SKUs, and
bulk‑manage attribute values and taxonomy terms. It also ships an **Anonymize
Orders** action for GDPR‑style scrubbing — it overwrites selected orders' personal
fields (mail, IP, billing/shipping profile) with randomized junk, optionally only
for orders older than N days, and can be driven from cron.

On the security side, the module defines **no routes or permissions of its own** —
every action rides your existing Commerce/Drupal admin permissions (manage
variations, administer product attributes, administer taxonomy, order update) and
each action enforces the relevant entity access. The SKUs and the
order‑anonymization junk use PHP's `uniqid()`/`mt_rand()`, which are fine for
those purposes but are not security tokens.

The module bundles one submodule, **Commerce Generate** (`commerce_generate`),
which integrates with Devel Generate to fabricate dummy products with variations
for testing. (Note: the maintainer expects this module to be deprecated once the
equivalent feature lands in Drupal Commerce core.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the Commerce Generate submodule.

There is **no central settings form** for this module. You control SKU generation
through a field widget on the variation type's form display, and you run the bulk
operations from the actions on the Variations tab and related pages (see below).

## Where it lives in the admin menu

Commerce Bulk works inside existing screens rather than adding a settings page:

- **Per‑product Variations tab** — `/product/{id}/variations` is where you generate
  and bulk‑manage a product's variations.
- **SKU widget** — configure the SKU prefix/suffix pattern, the unique‑id toggle,
  and the per‑run cap on the variation type's **Manage form display**.
- **Bulk actions** also appear on the product‑attributes, taxonomy, and orders
  listing pages, powered by core Action config entities and the module's bundled
  Views.

## How to use it

1. Install and enable the module.
2. On a product‑variation type's **Manage form display**, configure the **Bulk
   SKU** widget — set your SKU pattern and, if you like, hide the SKU field so
   SKUs are auto‑generated.
3. Open a product's **Variations** tab (`/product/{id}/variations`). You'll see a
   "created / not used / maximum" count and warnings about duplicated attribute
   combinations.
4. Run the actions you need — **Create** all (or a capped subset of) variations,
   **Duplicate**, **Set price**, **Adjust price**, **Change status**, regenerate
   **titles** or **SKUs**, or **Delete**.
5. Use the attribute‑value and taxonomy bulk actions to create, rename, reorder,
   or delete those in bulk.
6. For GDPR scrubbing, use the **Anonymize Orders** action (optionally limited to
   orders older than N days, and runnable from cron).
