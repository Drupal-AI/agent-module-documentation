# Highlight Js syntax highlighter — manual setup guide

**Highlight Js syntax highlighter** (`highlight_js`) brings syntax‑highlighted
code blocks to **CKEditor 5**. It joins two halves of publishing code on a Drupal
site: an editor button that lets an author insert a code snippet and pick its
language, and the [Highlight.js](https://highlightjs.org/) library that colours
the result. If your site publishes documentation, a developer blog, a knowledge
base, or tutorials, this is what makes code look like code.

When an editor clicks the Highlight.js button in the toolbar, a dialog opens with
a language selector and a "Source Code" text area. On the rendered page, the
snippet is wrapped in `<pre>`/`<code>` and styled with the Highlight.js theme you
chose. Content editors don't need elevated permissions to insert code — that's
handled by the text format they already use.

Highlight.js supports 240+ languages and 250+ themes. A word of advice worth
taking early: **enable only the languages your site actually publishes**. The full
library is large, and trimming it to the handful of languages you use keeps pages
lean. The module depends on core **CKEditor 5**, runs on Drupal 9, 10, and 11, and
its settings form is protected by an `administer highlight_js configuration`
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the button to a text format,
   enable the filter, and choose languages, theme, and the copy button.

## Where it lives in the admin menu

Two places matter. The module's own settings (language list, theme,
copy‑to‑clipboard button) live at **Configuration → Content authoring → Highlight
Js** (`/admin/config/content/highlight-js`, the `highlight_js.settings` form). The
button and filter are turned on per text format at **Configuration → Content
authoring → Text formats and editors**
(`/admin/config/content/formats`). Full setup is in
[Configuration](configuration/index.md).
