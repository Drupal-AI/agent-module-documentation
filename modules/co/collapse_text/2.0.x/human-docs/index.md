# Collapse Text — manual setup guide

**Collapse Text** (`collapse_text`) is a text‑format input filter that lets
authors turn any section of body text into a collapsible, click‑to‑expand block.
You wrap content in `[collapse]…[/collapse]` markers (or the angle‑bracket form
`<collapse>…</collapse>`) and the filter converts it into a native HTML5
`<details>`/`<summary>` disclosure widget — no JavaScript framework, no custom
markup, just the browser's built‑in expand/collapse behaviour.

It is ideal for FAQ pages (hide each answer until its question is clicked),
long documentation sections, spoiler/hidden‑answer blocks, collapsible legal
text, or per‑version changelog entries. Sections can carry a title, start
collapsed by default (`[collapsed]…[/collapsed]`), take CSS classes, and be
nested inside one another. If you don't give a section a title, the filter
borrows the first heading (`<h1>`–`<h6>`) inside it, falling back to a
site‑configurable default title.

The module depends only on core's **Filter** module. It has **no permissions,
no submodules, and no dedicated settings page** — instead you enable and tune it
per **text format**, so nothing changes on your site until you turn the filter
on for a format. It works on Drupal 8.8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable the filter on a text format,
   get the filter ordering right, and set its two options.

## Where it lives in the admin menu

There is no page of the module's own. You work with it under **Configuration →
Content authoring → Text formats and editors**
(`/admin/config/content/formats`), where you enable and order the *Collapsible
text blocks* filter on each format that should support it.

## How to use it

Once the filter is enabled on a format (see
[Configuration](configuration/index.md)), authors simply wrap content in the
markers when writing in that format:

- `[collapse]…[/collapse]` — a collapsible section, open by default.
- `[collapsed]…[/collapsed]` — starts closed.
- `[collapse title="Section title"]…[/collapse]` — an explicit heading.
- `[collapse class="my-class other-class"]…[/collapse]` — add CSS hooks.
- `[collapse collapsed="collapsed" title="Details" class="x"]…[/collapse]` —
  combine options in one tag.

Sections can be nested. To output a literal `[collapse` in your text, prefix it
with a backslash (`\[collapse`). Theming is handled by two overridable Twig
templates (`collapse-text-details.html.twig`, `collapse-text-form.html.twig`) —
see the [`agent/`](../agent/start.md) docs for theming details.
