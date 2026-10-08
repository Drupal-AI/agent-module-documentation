# Hierarchical Term Formatter — manual setup guide

**Hierarchical Term Formatter** (`hierarchical_term_formatter`) is a field
formatter for taxonomy-term reference fields. Instead of showing just the term
you tagged content with, it renders that term together with its ancestry — for
example `News » Politics » Elections` instead of only *Elections* — so a reader
can see where the term sits in the vocabulary.

You control exactly which part of the tree appears: the full path, just the
ancestors (a breadcrumb-style trail), only the top-level "root" term, everything
except the root, or just the selected leaf term. You can also link each term to
its taxonomy page, choose the separator between terms (the default is ` » `),
wrap each term in a `<span>`, `<div>`, or list markup for styling, and reverse
the order so the child comes first.

The formatter shows up automatically wherever you have an entity-reference field
pointing at taxonomy terms — on nodes, media, users, Commerce products, or any
custom entity. It's configured per field and per view mode on the entity's
**Manage display** page, so you can render a full path in one view mode and just
the leaf term in another without touching code.

There is no admin settings page, no permission, and no Drush command — everything
lives in the field's display settings, which export cleanly with your
configuration for deployment.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Hierarchical Term Formatter has **no configuration page of its own**. You select
and configure it per field on a bundle's **Manage display** page — for Articles,
that's **Structure → Content types → Article → Manage display**
(`/admin/structure/types/manage/article/display`).

## How to use it

1. Make sure the entity has an **entity-reference field pointing at taxonomy
   terms** (for example a *Categories* or *Tags* field).
2. Go to that bundle's **Manage display** page (and pick the view mode you want to
   change, if not the default).
3. In the **Format** column for the taxonomy-term reference field, choose
   **Hierarchical Term Formatter**.
4. Click the gear/cog icon to open its settings and adjust:
   - **Terms to display** — which slice of the tree to show:
     - *All* — the term and every ancestor (the full path).
     - *Grouping* — merge multiple referenced terms that share a parent so the
       parent appears once.
     - *Parents* — the ancestors only, dropping the selected term (a breadcrumb
       trail).
     - *Root* — just the topmost term (useful for grouping content by top-level
       section).
     - *Non-root* — everything except the topmost term.
     - *Leaf* — just the selected term (like the default core display, but ready
       to switch to a fuller view later).
   - **Link each term to its taxonomy page** — turn the terms into navigation links.
   - **Reverse order** — put the selected term first and its ancestors after.
   - **Wrap each term** — wrap each term in nothing, a `<span>`, a `<div>`, or
     render the trail as an ordered/unordered list (`<ul>`/`<ol>` with each term
     as an `<li>`).
   - **Separator** — the text printed between terms; the default is ` » ` and you
     can use anything (` > `, ` / `, `→`), or leave it blank.
5. Click **Update**, then **Save** the display.

The output is themeable: the module ships a
`hierarchical-term-formatter.html.twig` template you can copy into your theme, and
it adds CSS hooks such as `.terms-hierarchy`, `.separator`, `.child-separator`,
and `.taxonomy-term` for styling the trail.
