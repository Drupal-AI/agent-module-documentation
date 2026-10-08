# Inspire Tree — manual setup guide

**Inspire Tree** (`inspire_tree`) makes the Inspire Tree JavaScript library
available to Drupal as an asset library, so other code can build interactive
hierarchical **tree** interfaces with it. Inspire Tree offers the behavior people
expect from a file browser — lazy-loaded nodes, search within the tree,
multi-select with parent/child propagation, and expand/collapse — which is exactly
what Drupal usually lacks when it renders a hierarchy.

The problem it addresses is familiar: Drupal tends to render hierarchies as
indented tables with drag handles. A taxonomy vocabulary with four hundred terms,
a deep menu, an organizational chart, or a category picker each becomes a flat
indented list that stops being usable past a couple of hundred rows. Inspire Tree
is a library built for that job, and this module is the bridge that lets Drupal
code attach it.

Be clear about scope: at present the module **only provides basic library
integration**. It does not ship a ready-made field, widget, or Views display — it
does nothing on its own, and other code must attach the library and wire it up to
your data. It supports Drupal 8.8 through 11.

> **Important — this module has site-wide reach.** Its `info.yml` contains a
> `libraries-override` that replaces core's **Underscore** library with **Lodash**
> for the *entire site* (`core/underscore` → `inspire_tree/lodash`). The two are
> broadly compatible by design and this substitution is common, but it is a global
> change made by a module whose stated purpose is a tree widget — any other code
> that depends on `core/underscore` will then run against a different
> implementation. Check this before installing on a site with significant custom
> JavaScript.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module exposes a settings form at **Configuration → Services → Inspire Tree**
(`/admin/config/services/system/inspire-tree`), behind the **Administer site
configuration** permission. Because the module is a bare library provider, the
day-to-day work is not on this form but in the code that attaches the library —
see below.

## How to use it

Inspire Tree is a **library provider**, so using it means writing (or installing)
code that attaches the `inspire_tree` asset library and initializes a tree against
your data. There is no turnkey field or display to configure through the UI. If
you need a specific integration — for example a term-reference widget or a Views
display built on Inspire Tree — that would come from custom code or a companion
module built on top of this one.
