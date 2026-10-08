# Taxonomy Parent Autocomplete — manual setup guide

**Taxonomy Parent Autocomplete** (`taxonomy_parent_autocomplete`) fixes one specific,
painful problem: on a vocabulary with thousands of terms, the **Parent terms**
multi-select on the taxonomy term add/edit form becomes unusable — it renders a giant
`<select>` list of every term, which is slow to load and can even trigger
out-of-memory errors. This module swaps that dropdown for a type-ahead
**autocomplete** field, so editors just start typing to find the parent term instead
of scrolling an enormous option list.

It works entirely by altering the standard taxonomy term form — there are no routes,
services, blocks, or settings of its own. When you edit a term, the *Parent* field
becomes an entity-autocomplete restricted to the term's own vocabulary, and it
supports selecting **multiple parents** (for poly-hierarchies) by entering more than
one. Existing parents are preserved when you open a term, and saving a term with no
parent (a root term) works reliably. On install it also flips core's
`taxonomy.settings:override_selector` setting on, which suppresses the default parent
selector so this one takes over.

There is nothing to configure — the module applies automatically to all taxonomy term
forms the moment you enable it, and it is governed by your existing taxonomy edit
permissions, so it adds no new access surface. Note that this project is not covered
by Drupal's security advisory policy, which is worth knowing when you weigh it for a
production site.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it. That is all the setup there is.

## How to use it

Once enabled, just edit any taxonomy term as usual (**Structure → Taxonomy →** your
vocabulary **→** a term, or `/taxonomy/term/{tid}/edit`). Where the **Parent terms**
field used to be a long multi-select, you now type a few letters and pick the parent
from the autocomplete suggestions. To give a term more than one parent, add several
entries. Leave it empty to make the term a root (top-level) term.
