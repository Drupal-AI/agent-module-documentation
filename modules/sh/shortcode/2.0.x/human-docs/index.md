# Shortcode — manual setup guide

**Shortcode** (`shortcode`) brings WordPress‑style `[tag]...[/tag]` markup to Drupal text
formats. Once you enable its **Shortcodes** text filter on a format, any square‑bracket
tags an editor types into a field — `[quote author="Ada"]…[/quote]`, `[button]…[/button]`,
`[col]…[/col]` — are expanded into real HTML when the content renders. It gives
non‑technical content editors a lightweight way to drop in styled markup (quotes, buttons,
callouts, columns) without writing HTML or being granted a permissive text format.

Shortcode is a **framework, not a fixed set of tags**. On its own it provides the parser,
the text filter, and a `shortcode` plugin type — but it ships **no tags itself**. The
actual tags come from other modules: the bundled **Shortcode basic tags**
(`shortcode_basic_tags`) supplies a ready‑made set (highlight, dropcap, button, quote,
image, link, block, and more), the **Shortcode example** (`shortcode_example`) submodule is
a worked tutorial (a Bootstrap‑column tag), and any custom module can add its own by
implementing a small plugin class. Because tags are plugins, they can be nested inside one
another and can even render blocks or media inline.

There is **no central configuration page, no permissions, and no Drush** — everything is
controlled in each text format's filter settings, where you turn the filter on and tick
exactly which tags that format allows. A second filter, **Shortcodes — HTML corrector**,
cleans up the stray `<p>`/`<div>` wrapping that WYSIWYG editors like CKEditor insert around
block‑level tags. The module targets **Drupal 9.3+, 10, or 11** and depends only on core's
**Filter** module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — including how to write your own shortcode
plugin and call the service programmatically — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module, and
   add a tag‑providing submodule.
2. [Configuration](configuration/index.md) — enable the Shortcodes filter on a text format
   and choose which tags it allows.

## Where it lives in the admin menu

Shortcode adds no admin page of its own. You configure it entirely from **Configuration →
Content authoring → Text formats and editors**
(`/admin/config/content/formats`), on each text format's configuration page.

## How to use it

Enable the module and a tag‑providing submodule (such as **Shortcode basic tags**), then on
a text format tick the **Shortcodes** filter and select which tags to allow. From then on,
editors type the bracket tags into content using that format, and they expand to HTML on
render. Any tag you did *not* enable is left on the page as literal `[tag]` text rather than
being stripped, so nothing disappears unexpectedly. Full steps are in
[Configuration](configuration/index.md).
