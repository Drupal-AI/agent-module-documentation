# Paragraphs Editor Enhancements — manual setup guide

**Paragraphs Editor Enhancements** (`paragraphs_ee`) makes the "add paragraph" dialog
that Paragraphs shows editors far nicer to use. Instead of a plain list of buttons,
editors get searchable, icon‑rich **tiles** — each showing the paragraph type's label,
description and icon — that can be grouped into custom **categories** (tabs) so even a
long list of paragraph types stays scannable.

The enhanced dialog kicks in whenever a Paragraphs field widget's **Add mode** is set
to **Modal form**. Editors can switch the dialog between **Tiles** and **List** views,
filter/search types by title and description, and (optionally) open the picker as a
Drupal **off‑canvas** side panel instead of a centered modal. A new **Paragraphs
category** configuration entity lets you define named groups; each paragraph type can
then be assigned to one or more categories, and the dialog automatically adds "All" and
"Uncategorized" groups.

The module also surfaces the first few paragraph types as quick "add in between"
buttons, offers optional Gin‑theme accent styling and drag‑and‑drop reordering arrows,
and exposes a hook so other modules can allow or forbid its widget changes. It builds on
**Paragraphs Features** (which in turn requires **Paragraphs**) and needs Drupal core
**11.3**. An optional submodule, **Paragraphs EE Sets** (`paragraphs_ee_sets`),
integrates Paragraphs Sets into the same dialog.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Paragraphs Features and Paragraphs), enable it, and pick the submodule if you need
   it.

## Where it lives in the admin menu

There is no single settings page. The enhancements are configured in a few places:

- **Manage form display** on the entity holding your Paragraphs field — set the
  widget's **Add mode** to **Modal form**, and adjust the module's per‑widget options
  there.
- **Paragraphs categories** at **Structure → Paragraphs categories**
  (`/admin/structure/paragraphs_category`) — define the category tabs, gated by the
  **Administer paragraphs categories** permission.
- **Paragraphs types** (`/admin/structure/paragraphs_type`) — upload an icon for each
  type and assign it to categories.

## How to use it

**1. Turn on the enhanced dialog.** On the content type (or other entity) that holds
your Paragraphs field, go to **Manage form display**, open the Paragraphs field
widget's settings, and set **Add mode** to **Modal form**. That's what activates the
tiled dialog. In the same settings you can also toggle module options such as opening
the picker **off‑canvas**, choosing the **Tiles** vs **List** display, enabling
**drag‑and‑drop** arrows, and hiding the dialog **sidebar**.

**2. Give paragraph types icons.** Edit each paragraph type at **Structure →
Paragraphs types** and upload an **icon** — the dialog shows it on the tile (falling
back to a default image if none is set), which makes types much easier to recognize.

**3. Create categories.** At **Structure → Paragraphs categories**, add category
entities (each with a label, a formatted description, and a **weight** to order the
tabs). Then, on each paragraph type's form, use the **Paragraphs categories**
checkboxes to place that type under one or more category tabs. The dialog adds "All"
and "Uncategorized" groups automatically.

That's it — editors now see a searchable, categorized, icon‑based picker when they add
paragraphs. Category definitions and per‑widget settings export with your configuration.
