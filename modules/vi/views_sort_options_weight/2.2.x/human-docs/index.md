# Views Sort By Options Weight — manual setup guide

**Views Sort By Options Weight** (`views_sort_options_weight`) adds Views sort
handlers that order results by a **weight you assign to each value**, instead of
sorting alphabetically or numerically by the stored value. It solves a common
annoyance: a status field with values *Critical*, *High*, *Low* normally sorts
alphabetically (so *High* comes before *Low* comes before *Medium*), when what you
actually want is a deliberate business order.

It provides three sort plugins: one weights each **allowed value of a list field**
(`list_string`, `list_integer`, or `list_float`), one weights each **bundle of an
entity type**, and one weights each **user role**. When you add one of these sorts to
a View, its options form lists every value with a numeric weight box, and the sort
orders rows by those weights (any value you did not give a weight falls to the bottom).

Everything is configured inside the View — there is no settings page, permission, or
Drush command — and these sorts are set by the View builder, so they cannot be exposed
to site visitors. It requires only core **Views** and works on Drupal 8.9 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. You add the sort handlers inside a View at
**Structure → Views** (`/admin/structure/views`).

## How to use it

Configuration happens entirely inside a View (you need the *Administer views*
permission):

1. Edit the View you want to reorder.
2. Under **Sort criteria**, click **Add**, and look for the **"… (set weight)"**
   variant of your field, your entity type's bundle field, or the user roles field —
   for example *Priority (set weight)*. These extra sort options are added next to the
   real fields automatically.
3. Add it. Its options form lists **every value with a numeric weight box**, seeded
   with sequential defaults (1, 2, 3, …). **Lower weight sorts first.** Set the weights
   to the order you want.
4. Optionally combine it with the standard **sort order** (ascending/descending) and
   add a secondary sort (date, title) to break ties.
5. Save.

The three handlers cover:

- **List fields** — weight each allowed value of a select-list field (e.g. order a
  status field *Critical → High → Low*).
- **Entity bundles** — weight each bundle so specific content types appear first
  (e.g. *Page* before *Article* before *Blog* in a mixed listing).
- **User roles** — weight each role to order a user list by role importance
  (e.g. *Administrator → Editor → Member*).

Good to know:

- **Unmatched values group at the end.** Any value without a configured weight — a
  legacy or removed allowed value, for instance — is treated as weight 1000, so such
  rows fall to the bottom. This is also how you push a catch-all "Other" option down:
  give it a high weight.
- **These sorts can't be exposed** to end users; the weights are curated by whoever
  builds the View, which is exactly the point — editorial control over ordering
  without adding a separate weight field to every entity.
- The role handler treats the *Authenticated user* role specially, since that
  membership is not stored the same way as other roles.
