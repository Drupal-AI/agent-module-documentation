# Configuration

Everything Tooltip Taxonomy does is driven by **filter conditions** — rules that
say "turn terms from these vocabularies into tooltips, in these places." You
create and manage them in the admin UI.

## Open the configuration page

1. Log in as a user with **Administer site configuration** or **Administer
   filters**.
2. Go to **Configuration → Content authoring → Tooltip Taxonomy**, or navigate
   directly to `/admin/config/content/tooltip_taxonomy`.

You'll see a draggable list of any existing conditions. Use **Add filter
condition** to create one, the drag handles to re‑order them, and the operations
links to edit or delete.

## Creating a filter condition

The add/edit form has these fields:

- **Name** — a label for the condition, so you can tell your rules apart.
- **Vocabularies** *(required)* — tick one or more vocabularies. Every accessible
  term in them becomes a candidate tooltip; the term's **description** is the
  text shown in the bubble.
- **Text formats** *(required)* — the text formats this rule applies to. A field
  is only processed if its format is selected here.
- **Paths** — restrict the rule to certain URLs (for example only under
  `/docs/*`), using Drupal's standard path condition. You can also negate it.
- **Content types** — limit the rule to chosen node types (for example only
  Articles).
- **View modes** — limit it to specific view modes (for example *Full content*
  but not *Teaser*). Leaving "all" selected applies it everywhere.
- **Fields** — pick specific text fields (like *Body* or a `field_*` text field)
  instead of all of them. Leave empty to process every text field.
- **Allowed HTML tags** — which HTML tags are kept inside the tooltip
  description. The default is `<b> <i> <strong> <span> <br> <a>`. Descriptions are
  sanitized down to this set, so editor markup can't inject scripts.
- **Excluded tags** — a list of HTML tag names inside which the module should
  *not* replace term names (for example `h1 h2 strong`), so you don't get
  tooltips inside your headings.

Save the condition. The module refreshes the affected content automatically, and
its cache invalidates whenever you change a term or a condition, so tooltips stay
in sync.

## Handling ambiguous terms with weight

The condition list is weighted (that's what the drag handles set). When the same
term name is matched by more than one condition, the **higher‑weighted**
condition wins. This lets you give "CMS" a general definition site‑wide and a
more specific one on a particular section of the site.

## Required: allow the tooltip markup in your text format

This is the step people most often miss. The automatically injected tooltips wrap
term names in `<span class="tx-tooltip tx-tooltip-text">…</span>`. Drupal's text
formats will strip that markup unless you allow it. Go to **Configuration →
Content authoring → Text formats and editors**, edit the format you selected in
your condition, and add the following to its **Allowed HTML** (Limit allowed HTML
tags filter):

```
<span class="tx-tooltip tx-tooltip-text">
```

Without this, the tooltips won't appear in filtered text.

## The field formatter

Separately from filter conditions, the module provides a **Tooltip Taxonomy**
field formatter for entity‑reference fields that point at taxonomy terms. To use
it, go to the entity's **Manage display** tab, find your taxonomy reference
field, and choose *Tooltip Taxonomy* as its format. Each referenced term then
renders as a tooltip using the same markup and styling. (The formatter has its
own **Allowed HTML tags** setting controlling which tags survive in the
description.)

## Styling and accessibility

Tooltips are styled by the module's own CSS (a dashed underline with a
`cursor: help`, and a bubble shown on hover or focus) — no JavaScript is
involved. The trigger is keyboard‑focusable, so tooltips work for keyboard users
too. To change the look, override the `tooltip-taxonomy.html.twig` template or
the module's CSS in your theme.
