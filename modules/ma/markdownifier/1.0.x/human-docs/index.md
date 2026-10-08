# Markdownifier — manual setup guide

**Markdownifier** (`markdownifier`) provides two field formatters that render a
referenced entity and then convert the resulting HTML into **Markdown**. Instead of
displaying a referenced node, paragraph, or media item as HTML, the field outputs a
Markdown representation of it — useful when you need clean Markdown to feed an LLM,
an export pipeline, a static‑site generator, or any Markdown‑consuming API.

The two formatters are:

- **Render entity to Markdown** — for **Entity reference** fields.
- **Render entity revision to Markdown** — for **Entity reference revisions**
  fields (the kind Paragraphs uses).

Both work by letting Drupal render the referenced entity to HTML as usual, then
running that markup through the `pixel418/markdownify` library via a post‑render
step, returning Markdown. Because it converts already‑rendered, already‑sanitised
output down to Markdown — rather than injecting any new markup — it does not add a
cross‑site‑scripting surface.

There is **no settings page, route, permission, or stored configuration** of its
own: you simply pick one of the formatters on a field's display. It requires the
`pixel418/markdownify` PHP library and supports Drupal 8, 9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (including the Markdownify library) and enable it.

There is **no configuration page** for this module. You set it up entirely on a
field's **Manage display**, as described under "How to use it" below.

## Where it lives in the admin menu

Markdownifier adds no admin page. You use it from **Structure → Content types → *(your
type)* → Manage display** (or the equivalent Manage display for any fieldable
entity), on an entity‑reference field.

## How to use it

1. Make sure you have an **Entity reference** field (or an **Entity reference
   revisions** field, e.g. a Paragraphs field) on the entity you are displaying.
2. Go to that entity's **Manage display**.
3. Set the field's format to **Render entity to Markdown** (for entity reference) or
   **Render entity revision to Markdown** (for entity reference revisions).
4. Save. The referenced content now renders as Markdown text wherever that display
   mode is used.

> **Tip:** This is an output‑side transformation, so pair it with a view mode or a
> dedicated display (for example a display mode consumed by an API or export) where
> Markdown, rather than HTML, is what you want.
