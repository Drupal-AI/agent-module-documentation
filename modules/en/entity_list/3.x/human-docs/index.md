# Entity List — manual setup guide

**Entity List** (`entity_list`) provides a dedicated **List** entity type for
building configurable listings of entities — a lighter-weight alternative to
Views for the common "just show me these entities" need. Views is powerful but
heavy when all you want is a simple, repeatable list of nodes, users, media, or
taxonomy terms; Entity List lets a site builder assemble that listing directly,
step by step, without wiring up a full View.

You choose the **source** of the data — the entity type (node, user, file, media,
taxonomy term, …), the bundle (article, basic page, a specific vocabulary, and so
on), the language (a specific site language or automatic detection of the current
one), how many results to show per page, and whether to show a pager. You then
choose what appears on the page: the result list itself, a count of items found,
filters, and pager placement. The behavior is driven by **plugins** — a query
plugin retrieves the entities, a display plugin renders them, and from version 3
onward extra plugin types handle additional display tabs, filter forms, and
sortable filters — so the module is fairly developer-oriented and extensible.

Entity List depends on Drupal core's **Layout Discovery** module and works on
Drupal 10.1 and 11. One thing to keep in mind: like any custom listing mechanism,
a list must honor **entity access** — an entity a visitor cannot view should not
appear in the list. When you build a list, verify its access behavior so private
content doesn't leak into a public listing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Layout
   Discovery dependency, then enable it.

Entity List has no single "settings" form — you configure each list as you build
it, through the list entity's own plugin-driven screens, described in "How to use
it" below.

## Where it lives in the admin menu

Once enabled, Entity List adds administration for creating and managing List
entities. You build and configure each list there, choosing its source and
display through the module's plugin steps.

## How to use it

1. Create a new **Entity List**.
2. Configure its **query** — pick the entity type and bundle to list, the
   language, the number of results per page, and whether to enable a pager.
3. Configure its **display** — choose how the results render, and add optional
   pieces such as the results count, filters, and pager placement.
4. From version 3, use the extra plugin types (extra display tabs, filter forms,
   sortable filters) if your list needs them.
5. **Verify entity access** on the finished list — confirm that content a given
   user cannot view does not appear for them.

> **Tip:** the recommended **FAPI_Collapsible** module can render a list's filter
> form as a collapsible element if you want a tidier filter UI.
