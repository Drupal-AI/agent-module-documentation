# Insert Block — manual setup guide

**Insert Block** (`insert_block`) lets content editors embed the rendered
contents of a block anywhere inside rich text using a simple placeholder:
`[block:BLOCK_ID]`. Type that tag into a node body (or any filtered text field)
and, when the page is displayed, it is replaced with the block's actual markup —
no PHP snippets, no theme regions required.

It works as a **text-format filter**. You enable the "Insert blocks" filter on
whichever text formats should support it (for example Full HTML), and from then
on any `[block:...]` tag in text run through that format is scanned and swapped
for the block's output. The `BLOCK_ID` is a block **entity ID**: the filter first
looks for a placed block by that machine name (for example
`[block:olivero_syndicate]`), and if it doesn't find one, it falls back to loading
a custom content block by its numeric ID (for example `[block:12]`). A legacy
Drupal 7 style `[block:module=delta]` is also tolerated.

The filter has one setting, **Check roles permissions** (on by default). With it
on, a placed block's role-visibility rules are respected, so a block restricted to
certain roles stays hidden from users who lack them. Turn it off on a format and
role-restricted blocks always render. (Custom content blocks are always rendered
either way.) Because the transformation happens only at display time, your stored
content keeps the raw `[block:...]` tag intact.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enabling the filter on a text
   format, the tag syntax, and the Check roles setting.

## Where it lives in the admin menu

Insert Block has **no settings page of its own**. You configure it through core's
text-format UI at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), where its filter appears in the list of
enabled filters.

## How to use it

1. Enable the "Insert blocks" filter on a trusted text format (see
   [Configuration](configuration/index.md)).
2. In a content field that uses that format, type `[block:BLOCK_ID]` where you
   want the block to appear.
3. Save and view the content — the tag is replaced with the rendered block.

Every matching tag in the text is replaced, so you can embed several blocks in one
field.
