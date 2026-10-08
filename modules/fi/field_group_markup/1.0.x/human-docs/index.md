# Field Group Markup — manual setup guide

**Field Group Markup** (`field_group_markup`) adds a **Markup** formatter to the
Field Group module. Normally a field group is used to *visually* group real
fields together (in tabs, fieldsets, accordions, and so on). This module lets a
field group instead render a block of arbitrary, processed HTML that you author
right in the display configuration — no template and no custom block required.

The markup you write goes through a Drupal text format, so it can contain any HTML
that format permits, and it is run through the token system — so tokens like
`[node:title]` or `[current-user:name]` resolve against the entity being rendered.
That makes it a handy, lightweight way to drop in help text, section headings,
legal or disclaimer copy, instructions next to a tricky field, or a token‑based
greeting such as "Editing [node:title]".

It works in both contexts: on a **Manage form display** (to add guidance to an
edit form) and on a **Manage display** (to add static or token‑driven content to
how the entity is shown). It reuses the standard Field Group chrome — an optional
HTML id, CSS classes, and the "display even when empty" toggle — and there is no
settings page or permission of its own; all configuration lives inside the field
group.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Field Group
   dependency) with Composer and enable it.

## Where it lives in the admin menu

Field Group Markup has **no admin page**. Its Markup format becomes available
wherever you add a field group — on an entity's **Manage form display** or
**Manage display** tab (for example **Structure → Content types → *(your type)* →
Manage form display**).

## How to use it

1. Go to an entity display — for example **Structure → Content types → *(your
   type)* → Manage form display** (or **Manage display**).
2. Click **Add field group**, give it a label and machine name, and choose
   **Markup** as the group's **Format**, then create/save it.
3. Open the group's **format settings** (the settings cog) and configure:
   - **Markup** — a rich‑text field where you author the HTML. Choose a **text
     format** from the dropdown; the HTML you can use is whatever that format
     allows, so pick the format carefully to control what is permitted.
   - **Classes** — space‑separated CSS classes added to the wrapper (default
     `form-wrapper`), useful for theming.
   - **ID** — an optional HTML id for the wrapper.
   - **Display element also when empty** — keep the markup showing even if the
     group wraps no populated fields (on by default), so purely informational
     blocks always appear.
4. Click **Update**, then **Save**.

Because the text is token‑processed, you can include tokens that resolve at render
time. And because it is filtered through a text format, the output is only as
permissive as that format — a good way to keep control over the HTML.
