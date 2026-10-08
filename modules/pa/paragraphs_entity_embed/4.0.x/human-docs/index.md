# Paragraphs Entity Embed — manual setup guide

**Paragraphs Entity Embed** (`paragraphs_entity_embed`) lets editors drop
Paragraph components straight into rich-text content. With a **Paragraphs** button
in the CKEditor 5 toolbar, an editor can insert a call-to-action, a card, a
pull-quote, an accordion — any paragraph type you allow — right in the middle of a
body field, without needing a separate paragraphs field on the content type.

Behind the scenes each embed is stored as its own small **`embedded_paragraphs`**
entity that wraps the paragraph the editor built, and the editor's text gets a
`<drupal-paragraph>` tag pointing at it. On output, a text-format filter swaps that
tag for the fully rendered paragraph, shown through a dedicated **Embed** view mode.
Because the embed is a real, revisionable entity, it can be edited in place, reused,
and queried.

Turning it on is done **per text format**, not from a single global settings page
(`configure` is `null`). For a given format you enable the *Display embedded
paragraphs* filter and add the Paragraphs button to that format's CKEditor 5
toolbar. Five permissions gate who can view, add, edit, delete, and administer
embeds, and the embed button itself has settings to restrict which paragraph types
can be inserted.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the `embedded_paragraphs`
entity, the plugin ids, and the dialog routes — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its CKEditor 5 / Embed / Paragraphs dependencies.
2. [Configuration](configuration/index.md) — enable embedding on a text format,
   grant the permissions, and tune the embed button.

## Where it lives in the admin menu

There's no single settings page. The pieces you touch are:

- **Text formats** at **Configuration → Content authoring → Text formats and
  editors** (`/admin/config/content/formats`) — where you enable the filter and add
  the toolbar button per format.
- The **embed button** settings at **Configuration → Content authoring → Embed
  buttons** (`/admin/config/content/embed`) — where you restrict paragraph types
  and the add mode.
- **Permissions** at **People → Permissions**.

See [Configuration](configuration/index.md) for the walkthrough.
