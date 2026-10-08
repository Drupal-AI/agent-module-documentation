# Taxonomy Term Sidebar — manual setup guide

**Taxonomy Term Sidebar** (`term_sidebar`) gives the taxonomy term add/edit form
the same two‑column "main content + advanced sidebar" layout that Drupal core
already uses for the node edit form. Out of the box, core renders the term form
as a plain single column; this module restructures it so the term's own fields
sit in the main region while secondary settings — the URL alias (path),
relations (parent/weight), and translation options — move into a collapsible
sidebar, alongside a small "Status" block showing the published state and
last‑saved time.

The result is a term‑editing experience that matches the familiar node‑editing
one, which is especially welcome on content‑heavy sites or vocabularies with many
custom term fields. Because the module reassigns every term field to the main
region automatically, your custom fields are included without any extra work.

It's a single‑purpose, zero‑configuration module: there is no settings form, no
permissions, no routes, and no dependencies. Enable it and it just works. It also
adapts to your admin theme — it has dedicated handling for **Claro** (two‑column
layout with mirrored save actions) and **Gin** (a sticky actions bar and a
sidebar toggle), and it detects subthemes of either. Themes that aren't G/Claro
or a subtheme of them fall through with no changes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no configuration page. The effect appears directly on the
taxonomy term add and edit forms (for example
`/admin/structure/taxonomy/manage/tags/add` or any term's **Edit** tab). The
delete form is deliberately left untouched.

## How to use it

There's nothing to set up beyond enabling the module. Once it's on, open any
taxonomy term's add or edit form and you'll see the new two‑column layout: term
fields on the left, and a sidebar on the right containing the Status block, the
URL alias settings, relations, and (on multilingual sites) translation options.
For the best result, use the **Claro** or **Gin** admin theme, since those get
the full styled two‑column treatment.
