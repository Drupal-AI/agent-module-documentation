# Paragraphs tabs bootstrap — manual setup guide

**Paragraphs tabs bootstrap** (`paragraphs_tabs_bootstrap`) organises the items
of a multi‑value Paragraphs field into **Bootstrap 5 tabs** (or pills), either
horizontal or vertical. It gives your front end a clean tabbed presentation and
your editors a matching **tabbed widget** for managing the same paragraphs — so a
content type with lots of paragraph components stays navigable both on the page
and in the edit form.

The module ships a field **formatter** (for display) and a field **widget** (for
editing) that pair together, plus front‑end libraries built on core's jQuery,
once, and js‑cookie (the active tab is remembered across interactions). It expects
a **Bootstrap 5 theme** for correct styling. The formatter offers a handful of
display options — vertical vs horizontal, tab vs pill mode, which form mode is
used for inline editing, a custom CSS class, appended bottom text, and hiding
selected row operation buttons.

It also provides a convenient **"add component" flow**: editors can add a new
paragraph through an AJAX modal without leaving the page. That mutating action is
properly gated — it requires the appropriate create permission on the paragraph
type, or the field's own permission where Field Permissions is in use, or edit
(update) access on the parent content. It is not open to anonymous users. It
depends on the Paragraphs module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Paragraphs.

There is **no global settings page** for this module — all of its options live on
the field's display and form display, described in "How to use it" below.

## How to use it

Set up the widget and formatter on your Paragraphs field:

1. Use a **Bootstrap 5 theme** so the tabs and pills are styled correctly.
2. Add a **Paragraphs** (entity reference revisions) field to your content type,
   allowing multiple values and one or more paragraph types.
3. Go to **Structure → Content types → *(your type)* → Manage form display** and
   set that field's **Widget** to **Paragraphs Tabs** so editors get the tabbed
   editing interface (with the AJAX "add component" button).
4. Go to **Manage display** and set the field's **Format** to **Paragraphs Tabs**
   for the front‑end tabs.
5. In the formatter (and widget) settings, choose your options:
   - **Vertical vs horizontal** tabs.
   - **Tab vs pill** presentation.
   - The **form mode** used when editing each paragraph inline.
   - A **custom CSS class** on the tab container for theming.
   - **Bottom text** appended under the tab set.
   - Which **row operation buttons** to hide, to simplify the editor UI.
6. Save. Editors now manage the paragraphs as tabs, and visitors see them as
   Bootstrap tabs or pills.
