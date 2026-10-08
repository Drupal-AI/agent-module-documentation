# CKEditor5 ID Attributes — manual setup guide

**CKEditor5 ID Attributes** (`ckeditor_id_attributes`) adds a toolbar button to the
CKEditor 5 rich-text editor that lets content editors set the HTML **`id`**
attribute on elements — without dropping to source view. That's what you need for
in-page anchor links (a table of contents that jumps to sections), stable IDs for
CSS/JS to target, or accessibility patterns like `aria-labelledby` that reference
an element by id.

The module wires a third-party CKEditor 5 JavaScript plugin into Drupal's editor
and exposes it as a single toolbar item, **ID Attributes**. There is no global
settings page — you configure it **per text format**: add the button to that
format's CKEditor 5 toolbar, and optionally turn on **"Show element IDs in the
editor"**, which draws each element's id as a small label above it *in the editing
view only* (a handy authoring aid that doesn't change the saved markup).

One thing to watch: the button also *grants* the `id` attribute on elements the
format allows. On a restricted format (like "Limited HTML" with an allowed-tags
list), adding this button extends that list to permit `id` on the relevant tags —
so make sure the format's HTML filtering allows `id` where your editors need it. On
an unrestricted "Full HTML" format there's nothing to worry about. The module
depends only on core's **CKEditor 5** and has no permissions or Drush commands of
its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside CKEditor 5.
2. [Configuration](configuration/index.md) — adding the button to a text format,
   the "show element IDs" option, and the HTML-filtering caveat.

## Where it lives in the admin menu

There is no settings page of its own. You configure it **per text format** under
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), on a format that uses CKEditor 5.
