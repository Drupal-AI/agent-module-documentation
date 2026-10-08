# Hide Node Title — manual setup guide

**Hide Node Title** (`hide_node_title`) lets content editors hide a node's title on
display, one node at a time. You add a checkbox field to a content type, and when an
editor ticks it, that node's title is suppressed when the page renders — useful for,
say, a landing page where the title is already baked into a hero image and repeating
it in text would look redundant.

It is presented as a simpler alternative to the Exclude Node Title module, and it
works with both standard content types and content types built with Display Suite.

An important clarification: this is a **display toggle, not access control**. Hiding
the title only affects how the node is presented; the title still exists as the
node's data and remains available through the API, other view modes, and elsewhere.
Do not use it to keep a title secret.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings page** for this module — you enable the behavior per content
type by adding a specific field, as described below.

## How to use it

1. Go to the content type you want to control, at **Structure → Content types →
   *(your type)* → Manage fields**.
2. Add a **checkbox** (Boolean) field with the machine name **`field_hide_title`**.
   Place it near the title on the form so editors can find it easily.
3. Save. From now on, when an editor edits a node of that type and ticks the
   **Hide title** checkbox, that node's title will be suppressed on display.

> **Tip:** If your content type uses nested field groups, group them with the
> **HTML element** (`htmlelement`) formatter for the hiding to behave correctly.
