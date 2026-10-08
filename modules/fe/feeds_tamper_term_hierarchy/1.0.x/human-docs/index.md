# Feeds Tamper Term Hierarchy — manual setup guide

**Feeds Tamper Term Hierarchy** (`feeds_tamper_term_hierarchy`) provides a
[Tamper](https://www.drupal.org/project/tamper) plugin that turns a single
delimited path string into a taxonomy term reference during a Feeds import —
creating any missing terms as it goes, and respecting the hierarchy. A source cell
such as `Term 1 > Term 2 > Term 3` becomes a reference to **Term 3**, and if any of
those terms don't yet exist they're created in the right parent/child order.

Matching is done by name *within a parent*, not across the whole vocabulary, so
`Animals > Dogs > Food` and `Animals > Cats > Food` produce two distinct "Food"
terms — one under each branch. Imports are idempotent: on re-import existing terms
are reused rather than duplicated. If you have several term paths to assign to the
same field, you can combine this plugin with Tamper's built-in **Explode** plugin.

A Tamper plugin transforms one source value as it flows through the import, so you
add this plugin to the field carrying the path string and configure it there — it
has no settings page of its own. Two settings on the tamper instance control its
behavior:

- **Allow terms to be auto created** *(on by default)* — turn it off to import only
  into an existing hierarchy; values whose terms don't exist are skipped instead of
  created.
- **Match the first term anywhere in the hierarchy** *(off by default)* — turn it
  on when the source carries partial paths, e.g. `B > C` for a vocabulary that
  already contains `A > B > C`. The first match wins; deeper segments are always
  resolved under the previously resolved parent.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Tamper and the core Taxonomy module.

There is **no site-wide configuration page** for this module — it has no settings
form of its own. The delimiter, vocabulary, and the two options above are set per
tamper instance on a Feed type, as described below.

## Where it lives in the admin menu

The plugin adds no admin page of its own. You use it from a Feed type's **Tamper**
tab at **Structure → Feed types** (`/admin/structure/feeds`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Create or edit a Feed type, and add the **taxonomy term reference** field to
   your mapping.
3. **This step is critical:** for that field choose the option **Reference by:
   Term ID**.
4. Open the Feed type's **Tamper** tab, and on the same field add the **Import
   Taxonomy Terms Hierarchy** plugin.
5. Set the right **delimiter** (default `>`) and choose the target **vocabulary**,
   and adjust the *auto create* and *match first term anywhere* options as needed.
6. Create a feed of that type and import as usual.
