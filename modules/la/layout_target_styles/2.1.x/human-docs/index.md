# Layout Target Styles — manual setup guide

**Layout Target Styles** (`layout_target_styles`) adds free‑text **HTML ID** and
**CSS class** fields to
[Layout Builder](https://www.drupal.org/docs/8/core/modules/layout-builder) blocks
and sections, so a themer can target them precisely with custom CSS (or JavaScript)
without writing preprocess code or template overrides.

Out of the box, Layout Builder gives you no way to say "this particular block
should have the ID `#promo`" or "add the class `bg-muted` to this section." This
module fills that gap. When it is enabled, a **Block layout target styles** group
appears automatically on the add‑block, update‑block, and configure‑section forms,
containing two fields: a **Block HTML ID** and **Block HTML Classes**. Whatever you
enter is stored as part of the layout and rendered onto the element's HTML
attributes, so your theme's CSS can hook onto it, you can add anchor links to a
section, scope a JavaScript behavior to a block, or apply utility/framework classes
per instance — all without creating a new block type just to vary appearance.

Because the values you enter become HTML attributes, they travel with the layout:
they persist in the section storage and export along with a default layout. There
is essentially nothing to set up beyond enabling the module — the fields are there
the moment Layout Builder is on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Layout Builder.

There is **no settings form** for this module. Its fields appear directly on the
Layout Builder block and section forms, described below.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it from within the Layout Builder
editor, wherever you add or configure a block or a section.

## How to use it

1. Make sure core's **Layout Builder** is enabled and in use on the entity you are
   editing.
2. In the Layout Builder editor, add or configure a **block**, or configure a
   **section**.
3. Find the **Block layout target styles** group on the form and fill in either or
   both fields:
   - **Block HTML ID** — a single HTML `id` for the element (useful for in‑page
     anchor links or scoping JavaScript).
   - **Block HTML Classes** — one or more CSS classes to add to the element (useful
     for utility/framework classes or grouping several elements under one class).
4. Save the block/section, then save the layout. The ID and classes are applied to
   the rendered markup, ready for your theme's CSS to target.

> **A note on trust.** The ID and class strings you type are rendered into HTML
> attributes. As with any Layout Builder editing, keep Layout Builder access
> limited to trusted roles.
