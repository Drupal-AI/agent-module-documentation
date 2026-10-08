# Paragraphs Edit — manual setup guide

**Paragraphs Edit** (`paragraphs_edit`) lets editors change one paragraph directly,
without opening the entire host entity's edit form. On a long landing page built
from many paragraphs, fixing a typo in the middle section normally means loading
the whole node edit form; with Paragraphs Edit you hover over that one rendered
paragraph and get **Edit**, **Clone**, and **Delete** links right there.

It builds on the **Paragraphs** module and core's **Contextual Links**, and adds a
`paragraph` contextual-links group to every rendered paragraph on the front end
(the links are hidden inside the admin/QuickEdit contexts to avoid conflicts).
Each link opens a dedicated per-paragraph form: **Edit** shows just that
paragraph's own fields, **Delete** removes it from its parent and re-saves, and
**Clone** duplicates it and lets you drop the copy onto a different entity, bundle,
parent, or field. It even reaches deeply nested paragraphs (a paragraph inside a
paragraph) by walking up the chain to the top host entity. Saving is
revision-aware: if the host bundle is set to create new revisions by default, the
whole lineage — the paragraph plus each of its ancestors — is saved as new
revisions so revision references stay consistent.

The module works the moment you enable it — there is **no settings form, no
configuration, and no permissions of its own**. Access is governed entirely by
Drupal's normal entity-access rules (see "How access works" below), so whoever can
edit the host node can already edit its paragraphs. Two services (a lineage
inspector and a lineage revisioner) and a form-helper trait are available if you
want to reuse the machinery in custom code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Paragraphs and Contextual Links.

## Where it lives in the admin menu

Paragraphs Edit adds no admin pages. Its Edit / Clone / Delete affordances appear
as contextual links directly on rendered paragraphs on the front end. The forms
they open live at `/paragraphs_edit/{root_parent_type}/{root_parent}/paragraphs/{paragraph}/{edit|clone|delete}`.

## How to use it

1. View a page that renders paragraphs while logged in as a user who can edit it.
2. Hover over a paragraph and open its contextual links (the pencil/gear icon —
   you need the core **Use contextual links** permission for these to appear).
3. Choose **Edit paragraph** to change just that paragraph, **Clone paragraph** to
   duplicate it (optionally onto another entity/field), or **Delete paragraph** to
   remove it.

### How access works

The module defines no permissions. Instead, each action is checked against core
entity access:

- **Edit** and **Delete** require *update* access to the top host entity (the "root
  parent") — so anyone who can edit the host node can edit or delete its
  paragraphs.
- **Clone** requires *update* access to the paragraph itself, and at save time also
  checks that you can update the chosen destination entity and edit the chosen
  destination field.

If you need finer, per-paragraph-type control, that comes from other modules (such
as the Paragraphs `paragraphs_type_permissions` submodule) — Paragraphs Edit does
not add it.
