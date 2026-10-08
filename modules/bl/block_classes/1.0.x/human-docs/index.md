# Block Classes — manual setup guide

**Block Classes** (`block_classes`) lets you attach your own CSS classes to a
block straight from the block placement form — no Twig, no theme deployment. It
adds three optional text fields to every block's configuration form: one for
classes on the block's **wrapper**, one for classes on its **title**, and one for
classes on its **content**. Type in whatever classes you need (space-separated),
save, and they appear in the block's markup.

This is handy whenever you want to style a *specific* placement of a block rather
than every block of that type. You can drop a utility class like `mb-4
text-center` onto one hero block, switch a listing between grid and list layouts
by adding a class to its content wrapper, hide a title accessibly with
`visually-hidden`, tag a block with a JavaScript hook class for a scroll
animation, or add print-only helper classes — all per placement, and all visible
to the site builder who placed the block.

Because the classes are written to the standard block template variables
(`attributes`, `title_attributes`, `content_attributes`), any well-behaved theme
picks them up automatically. The class assignments are stored as part of the
block's configuration, so they export and import with the rest of your config.
The module has **no settings page of its own** — the only thing it adds is those
three fields on the block form, gated by a dedicated permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

## Where it lives in the admin menu

The module adds no page of its own. You use it through **Structure → Block
layout** (`/admin/structure/block`): the three CSS-class fields appear on each
block's **Configure** form.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Configure** on the block placement you want to style.
3. Fill in any of the three fields — **Block CSS class(es)**, **Title CSS
   class(es)** and **Content CSS class(es)**. Separate multiple classes with
   spaces (for example `card card--wide`).
4. Click **Save block**.

The classes now appear on the block's wrapper, title and/or content in the
rendered page, ready for your theme's CSS or JavaScript to target. Leave a field
empty if you do not need it — empty values are simply dropped.

A few things worth knowing:

- The three fields only show for users who have the **Administer block css
  classes** permission (see [Installation](installation/index.md)). Without it the
  fields are hidden, but any classes already saved keep rendering.
- Classes are lightly sanitised when rendered, so stick to valid CSS class names.
  Avoid starting a class with a digit (for example `1col` will not render as
  written).
- A handful of special blocks that render without an internal id (such as some
  Page Manager block widgets) do not receive the classes.
