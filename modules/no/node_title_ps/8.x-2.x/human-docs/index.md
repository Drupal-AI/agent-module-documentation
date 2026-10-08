# Node Title Prefix/Suffix — manual setup guide

**Node Title Prefix/Suffix** (`node_title_ps`) adds a configurable static **prefix**
and/or **suffix** to node titles as they appear on display. Instead of editing every
node's title, you set the extra text once per content type — for example prepending a
category label or appending a site tag — and it is added to the displayed page title
of all nodes of that type.

It is a content‑display feature: the prefix/suffix is admin‑configured and only
affects how titles are rendered, not the stored title value, and it plays no content
or access‑control role. A bundled submodule, **Taxonomy Term Name Prefix**
(`taxonomy_term_title_ps`), extends the same behavior to taxonomy term titles. The
module depends only on core's **Node** module.

There is no central settings form; you configure the prefix and suffix on each entity
type's own edit page (the content type edit form for nodes). Enable the module, open a
content type, and set the values.

> The module's own project page suggests that, for new sites, you may prefer its
> successor **Metatag: Page Heading**, which offers per‑entity overrides. Node Title
> Prefix/Suffix remains a simple, focused choice when you just want static per‑type
> text.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally enable the taxonomy‑term submodule.

There is **no central configuration page** for this module — you set the prefix and
suffix on each entity type's edit form, described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Content types** (`/admin/structure/types`) and edit the content
   type you want to decorate.
3. On the content type's edit page, set values for the **prefix** and/or **suffix**.
   Save.
4. View a node of that type — the configured prefix/suffix now surrounds its displayed
   title.

If you enabled the **Taxonomy Term Name Prefix** submodule, the equivalent
prefix/suffix settings appear on the taxonomy vocabulary edit page and apply to term
titles.
