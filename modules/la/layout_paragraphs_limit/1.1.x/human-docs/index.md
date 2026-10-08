# Layout Paragraphs Limit — manual setup guide

**Layout Paragraphs Limit** (`layout_paragraphs_limit`) gives you fine‑grained
control over which Paragraph types editors may drop into each region of a
[Layout Paragraphs](https://www.drupal.org/project/layout_paragraphs) layout —
and how many components each region will accept. Out of the box, Layout
Paragraphs lets an editor add any allowed Paragraph type into any region; this
module lets you narrow that list region by region, so a sidebar can be limited
to "Card" and "Callout" while a hero region accepts only a single banner.

It works entirely through a single settings form. For every layout that is in
use by your layout‑enabled Paragraph types, the form shows each region with
three controls: whether to *include only* or *exclude* the types you check, the
checklist of Paragraph types, and an optional cap on the total number of
components. The rules are saved as ordinary configuration
(`layout_paragraphs_limit.settings`), so you can deploy them between
environments like any other config.

The restrictions apply at edit time only — they shape the "add component" menu
an editor sees. They never alter or delete paragraphs that are already stored.
The module adds no permissions of its own (the form uses core's *Administer site
configuration*), no plugins, and no Drush commands. It requires Layout
Paragraphs 2.x or 3.x.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Layout Paragraphs.
2. [Configuration](configuration/index.md) — the region‑restriction form, field
   by field.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Content authoring →
Layout Paragraphs Limit** (`/admin/config/content/layout_paragraphs/limit`).
Access is gated by core's *Administer site configuration* permission.

## How to use it

Build your layouts with Layout Paragraphs as usual, then open the Layout
Paragraphs Limit form. For each region you care about, pick include or exclude
mode, check the Paragraph types the rule applies to, and optionally set a
component cap. Save, then edit a piece of content — the "add component" menu for
that region now offers only the types you allowed. Regions you leave untouched
keep accepting everything.
