# Paragraphs Paste — manual setup guide

**Paragraphs Paste** (`paragraphs_paste`) speeds up building paragraph-based
content by turning **pasted content into paragraphs automatically**. Instead of
adding paragraphs one at a time and choosing a type each time, an editor pastes a
block of content into a paste area on the form, and the module figures out which
paragraph types to create from what was pasted. Paste a block of text and it
becomes a text paragraph; paste a YouTube or video link and it creates a
paragraph suited to hold that video/media. It's a real time-saver when you're
assembling a page from many small pieces.

The module inspects the pasted input to decide the paragraph type, then creates
the matching paragraphs in your Paragraphs field. The pasted content becomes
ordinary authored content, rendered through Drupal's normal text filtering, so
there's no special access-control role here. It depends on the **Paragraphs**
module and supports Drupal 9 through 11. Development happens on GitHub
(thunder/paragraphs_paste).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** for this module. Its behavior is set up per
Paragraphs field on the field's form display, where you enable the paste area and
associate paragraph types with the kinds of content they should hold.

## How to use it

1. Make sure the **Paragraphs** module is enabled and you have a Paragraphs field
   on a content type.
2. Enable Paragraphs Paste (see [Installation](installation/index.md)).
3. On the host bundle's **Manage form display**, turn on the paste behavior for
   your Paragraphs field so a paste area appears on the edit form. This is also
   where you configure how pasted content maps to your paragraph types (for
   example, which paragraph type holds a video, which holds plain text).
4. When editing content, paste text or a media link (such as a YouTube URL) into
   the paste area. The module creates the appropriate paragraph type(s)
   automatically, and you continue editing from there.
