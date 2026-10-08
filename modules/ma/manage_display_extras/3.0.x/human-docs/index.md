# Manage Display Extras — manual setup guide

**Manage Display Extras** (`manage_display_extras`) adds extra field-display
options on top of the
[Manage Display](https://www.drupal.org/project/manage_display) module. Where
Manage Display already lets you turn field labels and values into things like
headings and links on a bundle's *Manage display* screen, this add-on extends
that with additional controls — most notably a **title formatter for string
fields that lets you add CSS classes to the link** it renders.

It's a site-building helper, not a content or access feature: everything it does
happens on the **Manage display** configuration for your content types (and other
fieldable entities). There's no settings form of its own — you pick its
formatters and options field by field, right where you already configure how
fields appear.

An optional submodule, **manage_display_node_created**
(`manage_display_node_created`), extends the same idea to the node "created"
(authored-on) field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add the optional submodule if you need it.

There is **no configuration page** for this module — it has no settings form. Its
options appear directly in **Manage display**, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Content types →
*(your type)* → Manage display** (and the equivalent *Manage display* tab for any
other fieldable entity). Its formatters and options appear alongside the standard
ones for the relevant fields.

## How to use it

1. Make sure the base **Manage Display** module is enabled (it's a required
   dependency).
2. Go to a bundle's **Manage display** screen.
3. For a **string field** you want rendered as a title/link, choose the title
   formatter this module adds, then open its settings (the gear icon) to enter
   the **CSS class(es)** you want applied to the rendered link.
4. Save the display. The field now renders as a linked title carrying your
   classes, ready for your theme to style.

If you enabled **manage_display_node_created**, the same kind of extended display
control becomes available for the node's *Authored on* (created) field.
