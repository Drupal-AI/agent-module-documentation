# Ckeditor5 HTML Embed — manual setup guide

**Ckeditor5 HTML Embed** (`ckeditor_html_embed`) adds an "HTML embed" button to the
CKEditor 5 toolbar, letting editors paste and embed an arbitrary raw HTML snippet —
an iframe (maps, calendars, booking widgets), a third-party `<script>` widget,
custom markup copied from another system — directly inside body content. It's the
escape hatch for the cases core's media embed doesn't cover.

The module is a thin wrapper around CKEditor 5's official `HtmlEmbed` feature. It
ships no PHP and no settings page; it just registers the CKEditor plugin, a toolbar
button labelled **HTML Embed**, and the styling for its icon. It also tells
Drupal's allowed-HTML handling which elements it produces (`<div>` and
`<div class="raw-html-embed">`) so your text-format filters know about them.
Previews are turned off, so the editor shows the raw HTML source exactly as pasted.

Because embedded HTML can contain scripts and iframes, this is a feature for
**trusted roles only**. Add the button to a restricted format (like an
administrator-only "Full HTML"), and rely on each format's "Limit allowed HTML
tags" filter to constrain what less-trusted editors can embed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it depends on core CKEditor 5).

## Where it lives in the admin menu

There is no dedicated settings page. You turn the feature on per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), by adding its toolbar button to a format that
uses CKEditor 5.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors** and click
   **Configure** on a format that uses **CKEditor 5** (for example Full HTML).
2. In the toolbar configurator, drag the **HTML embed** button from *Available
   buttons* into the *Active toolbar*.
3. If that format has **"Limit allowed HTML tags and correct faulty HTML"** enabled,
   make sure it permits the tags you want editors to embed. The module itself
   declares `<div>` and `<div class="raw-html-embed">`; add any others (such as
   `<iframe>` or `<script>`) your editors need — and only on formats meant for
   trusted roles.
4. Save the format.
5. Edit a piece of content using that format. Click the new **HTML embed** button in
   the toolbar, paste your raw HTML, and it's embedded inline. Editors see the raw
   source (previews are intentionally off), and the snippet is wrapped in a
   `raw-html-embed` container that's easy to target from your theme's CSS.

### A note on security

Raw HTML can include `<script>` tags and iframes, which run in visitors' browsers.
Only add the HTML embed button to formats used by roles you trust, and lean on the
allowed-HTML filter to lock down everyone else.
