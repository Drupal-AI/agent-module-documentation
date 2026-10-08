# Layout Builder Widget — manual setup guide

**Layout Builder Widget** (`layout_builder_widget`) puts core **Layout Builder**
inside the entity **edit form**, so an editor arranges a page's layout in the same
place they write its content. Core's Layout Builder lives behind its own tab — you
save the node, switch to the *Layout* tab, arrange sections, and come back. That
separation is defensible, but it is friction for the common case where a page *is*
its layout, as on a landing page assembled entirely from components. This module
collapses the two steps into one.

Its key features:

- **Unified editing** — the Layout Builder interface is embedded directly in the
  entity edit form, so there's no save‑then‑switch‑to‑a‑tab‑then‑save dance.
- **Day‑one usability** — the layout UI is available immediately when creating a new
  entity, before it has been saved for the first time.
- **Translation support** — compatible with content translation, so each translation
  can have its own blocks and layout.
- **Multiple instances** — supports more than one Layout Builder instance on a single
  form, such as nested Paragraphs.
- **Admin theme integration** — because it lives on the edit form, it naturally
  respects your admin theme (Gin, Claro, etc.) rather than the front‑end theme
  context the standalone Layout Builder UI often uses.

It pairs naturally with the separate **Layout Builder Formatter** module: this module
handles the *editing* experience (the form widget), while Layout Builder Formatter
handles the *display* experience (positioning the layout output as a field in *Manage
display*). Access is still governed by Layout Builder's own permissions — the widget
just surfaces the same interface in a new place. It depends on core Layout Builder
and targets Drupal 10 and 11.

Two things worth checking when you adopt it, from the module's own notes: the **save
semantics** change (core's Layout Builder tab has its own save and tempstore, which an
inline widget has to reconcile with the entity form's), so verify behaviour around
unsaved changes, validation errors and revisions on your site rather than assuming;
and confirm that layout **access** behaves as you expect, since it still follows
Layout Builder's permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated configuration page** for this module. You switch it on per
entity form via the *Manage form display* screen, described below.

## How to use it

You enable the widget from an entity's **Manage form display** screen:

1. Go to **Manage form display** for the entity you want — for example
   `admin/structure/types/manage/article/form-display` for the Article content type.
2. Make sure the **Layout** field is enabled (not in the *Disabled* region).
3. Set the Layout field's widget to **Layout Builder Widget** and save.
4. Now, when you edit (or create) an entity of that type, the Layout Builder
   interface appears directly on the edit form.
