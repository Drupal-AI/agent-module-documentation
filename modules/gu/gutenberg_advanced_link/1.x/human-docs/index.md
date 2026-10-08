# Gutenberg Advanced Link — manual setup guide

**Gutenberg Advanced Link** (`gutenberg_advanced_link`) enhances the link tool in
the **Gutenberg** editor. Gutenberg's built‑in link handling is basic; this module
adds the advanced link options editors often need — setting a link's attributes
such as `target`, `rel`, and CSS classes — when you create or edit a link in the
editor.

It is purely an authoring enhancement for sites using the Gutenberg editor: it
adds no content type, no permission, and no access role of its own. A small usage
tip from the maintainer: to remove a link, clear the URL field and leave it empty.

**A note for the security‑minded.** Any feature that lets editors add attributes to
links has a theoretical cross‑site‑scripting angle if it were to allow arbitrary
attributes (for example an `on*` event handler). In practice editor link
attributes are normally constrained to safe ones. If this matters for your site,
confirm the module restricts attributes to the safe set (`target`, `rel`, `class`),
and make it a habit to pair `target="_blank"` with `rel="noopener"`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it requires the
   Gutenberg module) and enable it.

## Configuration

There is no settings form for this module. Once it is enabled and the Gutenberg
editor is in use, the advanced link options appear automatically in the editor's
link UI — there is nothing to configure in the admin menu.

## How to use it

1. Edit content with the **Gutenberg** editor enabled.
2. Select some text and add or edit a link as usual.
3. Use the added **advanced link options** to set the link's attributes — its
   `target`, `rel`, and any CSS classes you want to apply.
4. To remove a link, empty the URL field.
