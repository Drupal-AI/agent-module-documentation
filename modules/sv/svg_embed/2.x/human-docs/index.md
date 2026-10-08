# SVG Embed — manual setup guide

**SVG Embed** (`svg_embed`) is a text filter that lets you embed an SVG graphic
**inline** into a node's text — much like inserting an image — and, uniquely,
translates the text strings inside the SVG into the language of the node. Because
the text in an inline SVG stays real, selectable text, it can help with SEO and is
searchable, and on multilingual sites the graphic automatically adapts to the
surrounding content or the visitor's language.

You use it with a simple token in your body text. Upload your SVG the normal Drupal
way (so the file exists on the server and is recorded in the managed-files table),
then drop a token such as `[svg:4711]` (where 4711 is the file ID) or
`[svg:my_graphic.svg]` (by filename) into the text. Since version 2.1 it also
replaces embedded **file** and **media** entities that point at SVG files. The
filter swaps the token for the SVG's content — translated on the fly — at render
time. Its only dependencies are the core **Locale** and **Filter** modules.

**Security — done correctly here.** Embedding SVG inline is inherently risky,
because SVG is an executable document format: an SVG can carry `<script>` and event
handlers, so inlining untrusted SVG is a classic stored-XSS vector. SVG Embed handles
this properly by running every SVG through the well-regarded `enshrined/svg-sanitizer`
library before output, which strips scripts, event handlers and other dangerous
constructs. That makes the inline embedding safe against the SVG-XSS risk — which is
exactly the control this feature needs. Your ongoing responsibility is simply to keep
the sanitizer library up to date.

**Translation** works through the interface translation system: your SVGs are
expected to contain English text originally, and you translate the extracted strings
per language, offline, via downloadable PO files. **Known browser issue:** inline SVG
text renders well in Firefox but does not always display correctly in Chrome and
Safari — this appears to be a browser quirk rather than a module bug.

This guide is written for a **human** setting the filter up through the admin UI. If
you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Setting up SVG Embed is a matter of enabling the filter on the right text formats
and then translating your SVG strings:

1. **Enable the filter.** Go to **Configuration → Content authoring → Text formats
   and editors** (`/admin/config/content/formats`) and edit each text format where
   you want to use SVG embedding. Enable the **SVG Embed** filter. To be safe that no
   other filter interferes with the SVG code, drag the SVG Embed filter to be the
   **last** one in the processing order.
2. **Embed a graphic.** Upload your SVG through any of Drupal's normal upload paths,
   then put `[svg:FILEID]` or `[svg:FILENAME]` into the body text of a node using that
   text format. You can also embed file or media entities that are SVGs.
3. **Translate the strings.** Go to **Configuration → Regional and language →
   User interface translation**, then **Embedded SVG**
   (`/admin/config/regional/translate/svgextract`). Download a PO file for each
   enabled language (all strings from all SVGs on your site come in one PO file per
   language), translate them offline, and upload the translated files back on the same
   form.
