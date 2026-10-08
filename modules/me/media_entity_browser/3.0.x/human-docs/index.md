# Media Entity Browser — manual setup guide

**Media Entity Browser** (`media_entity_browser`) ships ready‑made Entity Browser
configurations for core Media, giving editors a searchable, thumbnail‑grid picker
for choosing and embedding media — in WYSIWYG fields and in media reference
fields. Instead of an autocomplete or a plain file upload, authors get a proper
"media library" style browse experience for reusing images, videos, and documents
already on the site.

It is worth understanding what this module *is*: essentially a package of
**configuration** — an Entity Browser, a supporting View that lists your Media as
a styled thumbnail grid, an image style, and an Entity Embed button — rather than
custom PHP logic. On install it provides two browsers: an **iFrame browser** for
embedding media in WYSIWYG editors, and a **modal browser** for use with Inline
Entity Form "complex" media reference widgets. It also adds some CSS and JavaScript
to make the grid feel like a media picker.

Because it is all configuration, the browser is not visible until you wire it into
an Entity Embed button or a media reference field's form widget — and once
installed, you customize it through Entity Browser's own admin UI and manage the
result as exported config. An optional submodule offers an alternative browser
whose look mirrors core Media Library. This module predates full core Media
Library WYSIWYG support and is designed to fill that gap.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the Entity
   Browser and Inline Entity Form requirements) and enable the module.

## Where it lives in the admin menu

Media Entity Browser has no settings page of its own. You customize its browsers
through **Entity Browser's** admin UI at **Configuration → Content authoring →
Entity browsers** (`/admin/config/content/entity_browser`). You then attach a
browser where editors will use it: on an **Entity Embed button** (for WYSIWYG), or
on a media reference field's **form display** widget.

## How to use it

Installing the module gives you the browsers, but they do nothing until you point
something at them:

1. **For WYSIWYG embedding** — configure an **Entity Embed** button to use the
   iFrame media browser, and add that button to your text format's CKEditor
   toolbar. Editors then get a "browse media" button that opens the thumbnail grid
   to insert existing media into rich text.
2. **For a media reference field** — on the field's *form display*, use the Inline
   Entity Form "complex" widget wired to the modal browser, so editors pick media
   from the grid instead of typing an autocomplete.
3. **Customize the grid** — because the browser is driven by the
   `media_entity_browser` View, you can edit that View to filter selectable media
   by type or bundle, add a pager for large libraries, and so on. A thumbnail image
   style (`media_entity_browser_thumbnail`) is provided for previews.

Everything is configuration, so once you have it the way you like, export it and
deploy it across environments like any other config. If you would rather have a
browser that looks like core Media Library, enable the
`media_entity_browser_media_library` submodule (see
[Installation](installation/index.md)).
