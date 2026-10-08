# Taxonomy Manager — manual setup guide

**Taxonomy Manager** (`taxonomy_manager`) replaces Drupal's tedious,
one‑term‑at‑a‑time taxonomy administration with a single interactive tree
interface. If you have ever tried to build or reorganize a large vocabulary through
the core term list — paging through hundreds of terms, editing each one on its own
page — this module is the answer. At **Structure → Taxonomy Manager** you pick a
vocabulary and get a Fancytree‑powered, AJAX tree of every term and its hierarchy,
with bulk operations, inline editing, and search.

Select terms with checkboxes and the toolbar lights up with actions that open modal
dialogs: **Add** (mass‑add many terms at once, one per line, using `-` prefixes to
build parent/child depth and an optional delimiter to import descriptions on the
same line), **Delete** (bulk delete, optionally cleaning up orphaned children),
**Move** (re‑parent selected terms, optionally keeping their old parents to build
multi‑parent hierarchies), and **Export CSV / Export list**. Click a single term
and its full edit form loads beside the tree and saves over AJAX with no page
reload, and you can nudge term weights up and down with arrows that persist
instantly.

Access to term operations is governed mostly by core Taxonomy permissions
(`administer taxonomy`, and the per‑vocabulary create/edit/delete term
permissions), while the module adds an `access taxonomy manager list` permission
and per‑vocabulary export permissions of its own. A settings form tunes the tree
page size, the description delimiter, the hover behavior, and translation display.
The bulk logic lives in a reusable helper service, and an optional **Taxonomy
Manager Merge** submodule integrates the Term Merge module to fold duplicate terms
into one. It depends on core's **Taxonomy** module and the **jQuery UI** module,
and uses the Fancytree JavaScript library.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Fancytree
   library with Composer, enable it, and add the Merge submodule if you need it.
2. [Configuration](configuration/index.md) — the settings form and the permissions
   that gate each operation.

## Where it lives in the admin menu

The tree editor is at **Structure → Taxonomy Manager**
(`/admin/structure/taxonomy_manager/voc`), where you choose a vocabulary. The
settings form is separate, at **Configuration → User interface → Taxonomy Manager
settings** (`/admin/config/user-interface/taxonomy-manager-settings`).

## How to use it

1. Install the module and the Fancytree library, then enable it (see
   [Installation](installation/index.md)).
2. Go to **Structure → Taxonomy Manager** and pick a vocabulary.
3. Use the toolbar to **Add**, **Delete**, **Move**, or **Export** terms, and click
   any term to edit it inline. See [Configuration](configuration/index.md) for the
   settings and permissions.
