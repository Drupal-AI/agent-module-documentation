# CKEditor Section — manual setup guide

**CKEditor Section** (`ckeditor_section`) adds a toolbar button to CKEditor that
wraps selected content in a semantic HTML `<section>` element. It is a small,
focused authoring enhancement for editors who want to structure their content
meaningfully rather than relying on generic containers.

Semantic `<section>` elements help both accessibility and document structure by
marking off distinct thematic parts of a page. This module gives editors a
one‑click way to add that structure from the editor toolbar, without editing raw
HTML.

The one thing to get right is your text format's allowed HTML: for the section
markup to survive, the format's filter must permit `<section>`. If it does not,
Drupal's text‑format filtering will strip the element on output. Beyond that there
is no security surface to worry about. The module requires nothing outside Drupal
core and works on Drupal 9.3, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, add
   the button to a text format, and allow `<section>` in that format.

There is **no settings page** — the only setup is adding the button and allowing
the markup, described below and in Installation.

## Where it lives in the admin menu

The module adds no admin configuration page. You configure it per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`): add the **Section** button to the toolbar, and
make sure the format's allowed HTML includes `<section>`.

## How to use it

With the button on the toolbar, select the content you want to group, click the
**Section** button, and it is wrapped in a `<section>` element. Confirm your text
format allows `<section>` so the wrapper survives to the rendered page, and style
sections in your theme's CSS as needed.
