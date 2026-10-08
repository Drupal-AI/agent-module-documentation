# Layout Paragraphs Theme Extension — manual setup guide

**Layout Paragraphs Theme Extension** (`layout_paragraphs_theme_extension`) makes
the [Layout Paragraphs](https://www.drupal.org/project/layout_paragraphs) builder
render paragraphs using your site's **default (front‑end) theme templates** — and,
optionally, attach a CSS/JS library from that theme to the builder — so the editing
experience looks like the published page even while an admin theme is active.

Normally the Layout Paragraphs builder renders through whatever admin theme is in
effect, so what an editor sees while building a page can differ noticeably from
what a visitor sees. This module closes that gap. When enabled, it pulls
`paragraph.html.twig` and each `paragraph--[type].html.twig` override from your
default theme into the builder, and it can load additional templates you nominate
(node teasers, custom block templates, and so on). The result is a
WYSIWYG‑accurate preview inside the builder.

For true visual parity you will usually also want your front‑end CSS in the
builder. The module lets you name a theme library to attach to the builder UI. The
builder markup is wrapped in a `.lp-builder` CSS class, so you can scope an
editor‑specific stylesheet to that wrapper and avoid clashing with the admin
theme's own styles. The module is based on the community patch from Drupal.org
issue #3208180.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Layout Paragraphs and Paragraphs.
2. [Configuration](configuration/index.md) — turn the extension on, point it at a
   theme library, and list any extra templates to load.

## Where it lives in the admin menu

The settings form sits at **Configuration → Content authoring → Layout Paragraphs
→ Default Theme** (`/admin/config/content/layout_paragraphs/default-theme`), and
requires the **Administer site configuration** permission. Remember to rebuild
caches (`drush cr`) after changing settings, because theme‑registry changes only
take effect once caches are cleared.
