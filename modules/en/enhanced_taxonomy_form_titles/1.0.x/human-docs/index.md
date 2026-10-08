# Enhanced taxonomy form titles — manual setup guide

**Enhanced taxonomy form titles** (`enhanced_taxonomy_form_titles`) is a small
editorial-UX module that adds the **vocabulary name** to the page title of
taxonomy term forms. When you add, edit, or delete a term, the title now tells you
which vocabulary the term belongs to — a genuine relief on sites with many
vocabularies, where it is otherwise easy to lose track of which one you are
editing. It has no module dependencies.

It applies to the three main taxonomy term forms — **add**, **edit**, and
**delete** — and it **works the moment you enable it**. There is nothing to
configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it works out of the box.

## How to use it

Just enable it. Afterwards, go to **Structure → Taxonomy**, pick a vocabulary,
and add or edit a term — the form's title now includes the vocabulary name, so you
always know which vocabulary you are working in.
