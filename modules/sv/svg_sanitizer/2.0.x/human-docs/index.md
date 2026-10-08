# SVG Sanitizer — manual setup guide

**SVG Sanitizer** (`svg_sanitizer`) lets you safely display uploaded SVG images
**inline**. SVG is an XML format, and a malicious or careless SVG can carry
embedded `<script>` tags, JavaScript event handlers, and external references —
which, if rendered inline, become a stored cross‑site scripting (XSS) risk in
every visitor's browser. This module wraps the well‑maintained
`enshrined/svg-sanitize` PHP library and exposes it to Drupal as a **field
formatter**. When the formatter renders an SVG, it first reads the file, runs it
through the sanitizer to strip scripts, event handlers, external references, and
anything not on the library's allow‑lists, and then prints the cleaned SVG inline
as vector markup — so you get stylable, animatable SVG without the danger.

The formatter works on core **file** fields as well as the `svg_icon` and
`svg_image_field` field types. It has two optional per‑formatter settings —
**Allowed Tags** and **Allowed Attributes** — that let you *add* extra elements or
attributes on top of the library's defaults, per field and view mode. That's
useful when a legitimate SVG feature (say a filter or animation element) is
stripped by the strict defaults.

There is one crucial thing to understand about how it protects you:
**sanitization happens only at display time, and only where this formatter is
selected.** The module adds no upload‑time hook — the original file on disk is
untouched. If some other display (a file‑download link, a plain image formatter,
another SVG renderer) shows the same file, it serves the original, unsanitized
bytes. So you must choose the SVG Sanitizer formatter on **every** display where
untrusted SVGs are shown inline, and it's wise to pair it with upload‑side
extension and validation controls for defense in depth.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   sanitizer library) and enable it.
2. [Configuration](configuration/index.md) — selecting the formatter, its two
   allow‑list settings, and the security caveats to keep in mind.

## Where it lives in the admin menu

There is no global settings page. You configure SVG Sanitizer entirely on an
entity bundle's **Manage display** tab, by choosing the *SVG Sanitizer* formatter
for an SVG‑bearing field.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage display** tab of the bundle whose field holds SVGs and set
   that field's format to **SVG Sanitizer** (see
   [Configuration](configuration/index.md)).
3. Make sure every display that shows those SVGs inline uses this formatter.
