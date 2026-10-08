# Term Reference — manual setup guide

**Term Reference** (`term_reference`) adds a **References** tab to taxonomy term
pages, letting editors manage — from the term itself — the content that points at
that term through an entity‑reference field. Instead of opening each node one at a
time to tag it, you open the term, go to its References tab, and add or remove
content from that single place.

The situation it is built for: a site builder or editor is handed a list of
content items that all need to be associated with one taxonomy term. Doing that
node‑by‑node is tedious. Term Reference lets you do it from the term's page — it
automatically discovers which entity‑reference fields target the term's
vocabulary, then gives you an AJAX form to attach or detach content. It handles
several nice cases: a single‑field shortcut that opens the add/remove form
directly when only one field is available, a chooser when more than one field
qualifies, and cross‑bundle management (for instance managing both Basic page and
Article nodes from one `field_tags` page).

Access is handled carefully and there is no module‑specific permission. A user can
only manage references they would already be allowed to edit: the module requires
**update access to the taxonomy term** *and* **edit access to the specific
reference field** on the target content, and it re‑checks target entity update
access and field edit access before making any change. In other words it does not
open any new back door — it just relocates edits you could already perform.

The module works as soon as it is enabled — there is no configuration screen. It
simply surfaces any existing entity‑reference fields that target taxonomy terms.
It depends on core **Field** and **Taxonomy**, supports **Drupal 10 and 11**, and
ships no submodules. (Note: this project is not yet covered by Drupal's security
advisory policy, and its own docs mention it was created with AI assistance and
reviewed by humans.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

1. Make sure a fieldable content entity (content, media, etc.) has a **taxonomy
   term reference field** configured to target one or more vocabularies. Term
   Reference works with fields that already exist — it does not create them.
2. Visit a **taxonomy term page** from one of those vocabularies.
3. Open the **References** tab (a primary local task on the term page).
4. If one reference field is available, add existing entities via autocomplete, or
   remove existing references from the table of referencing entities. If several
   fields are available, choose the field first, then add or remove.

The listing table shows each referencing entity's Label, ID, Published status, and
operations, and additions/removals only succeed where you have the necessary edit
access.
