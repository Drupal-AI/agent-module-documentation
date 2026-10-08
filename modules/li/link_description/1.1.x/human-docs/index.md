# Link with description — manual setup guide

**Link with description** (`link_description`) adds a field type that behaves
exactly like Drupal's core **Link** field but carries one extra piece of
information: a multi-line **description** stored alongside each link's URL and
link text. It is the answer to the common request "I need a link field, but I also
want a sentence or two explaining where the link goes."

Because the field type extends the core Link field, everything you already know
about Link fields still applies — allowed link type (internal, external, or both),
whether link text is optional or required, `rel="nofollow"`, open-in-new-window,
URL trimming, and so on. The module simply layers a "Long description" textarea
onto the widget and offers two display formatters that render the description
underneath (or beside) the link. Descriptions preserve their line breaks on
output.

This is a **field module**: you use it purely by adding a field of type *Link with
description* to any fieldable entity (nodes, taxonomy terms, paragraphs, media…).
There is no settings page, no permissions, no Drush commands, and no service to
configure.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the field type,
widget, and formatter machine names and their template hooks — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Add the field like any other, then choose how it displays:

1. On a bundle's **Manage fields** page (for example
   **Structure → Content types → Article → Manage fields**), click **Add field**
   and choose **Link with description**. Give it a label and, if editors should be
   able to add several, set **Allowed number of values** to *Unlimited*.
2. Work through the usual core Link field settings — allowed link type and whether
   link text is required — then save.
3. On **Manage form display**, the widget shows the standard URL and link-text
   inputs plus a 3-row **Long description** textarea. This is where editors type
   the explanatory text for each link.
4. On **Manage display**, pick one of the two formatters:
   - **Link with description** — the compact core-style link followed by a
     description paragraph.
   - **Title and link URL with description** — the title, URL, and description
     rendered as separate pieces.

Both formatters keep the usual core Link display options (trim length, URL-only,
`rel`, `target`). The markup exposes `.link-item` and `.link-description` CSS
classes (and `.link-title` / `.link-url` for the separate variant) so you can
style it, or override the module's Twig templates in your theme for full control.
