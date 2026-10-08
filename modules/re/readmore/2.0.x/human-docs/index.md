# Readmore — manual setup guide

**Readmore** (`readmore`) adds a single field formatter that shows a trimmed
preview of a long‑text field with client‑side **Read more** / **Read less**
toggle links. Instead of printing an entire Body field on a listing page, you
show a short teaser and let the reader expand the full text in place — no page
reload, no heavier accordion or JavaScript module required.

You use it like any other field formatter: on an entity's *Manage display* tab
(or in a View's field settings) you pick **Readmore** as the formatter for a
`text`, `text_long`, or `text_with_summary` (Body) field, then open the gear
icon to tune how it trims. It works on the core `text`, `text_long`, and
`text_with_summary` field types and depends only on core's **Field** module.

There is no admin settings page, no permission, and no Drush command — Readmore
is purely a display formatter, configured per display where you use it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Readmore adds no menu items and no global settings page. You configure it
per‑display at **Structure → Content types → *(your type)* → Manage display**
(`/admin/structure/types/manage/<bundle>/display`), or inside a View's field
settings.

## How to use it

1. Go to the **Manage display** tab of the content type (or other entity bundle)
   that has your long‑text field — for example a Body field.
2. In the **Format** column for that field, choose **Readmore** from the
   dropdown.
3. Click the gear icon to open the formatter settings and adjust them to taste:

   - **Trim length** — the character count to trim to (default **500**). Text
     shorter than this renders untouched, with no toggle link.
   - **Trim on break** — if the text contains a `<!--break-->` marker (placed by
     an editor), cut there instead of at the trim length.
   - **Show read more** — append a *Read more* link to the trimmed preview.
   - **Show read less** — append a *Read less* link to the expanded text so
     readers can collapse it again.
   - **Ellipsis** — append `…` after the trimmed preview.
   - **Wordsafe** — truncate on a word, tag, or sentence boundary rather than
     mid‑word, so the preview doesn't cut awkwardly or break HTML.

4. Click **Update**, then **Save** the display.

On the rendered page the field now shows the trimmed preview with a *Read more*
link; clicking it expands the full text in place. Common uses include expandable
teaser/card descriptions, truncated comment or review bodies, collapsed FAQ
answers, and long product descriptions shown short on listing pages.

### Styling and theming

The output wraps the preview and full text in `.readmore-summary` and
`.readmore-text` blocks, with `.readmore-link` and `.readless-link` on the toggle
links — style these in your theme's CSS. To change the markup, override the
`readmore` theme hook or copy `templates/readmore.html.twig` into your theme; it
receives a `summary` variable (the trimmed markup) and a `text` variable (the
full markup).
