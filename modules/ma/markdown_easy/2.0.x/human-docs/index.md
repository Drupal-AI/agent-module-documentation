# Markdown Easy — manual setup guide

**Markdown Easy** (`markdown_easy`) is a text‑format filter that lets your editors
write in Markdown and have it rendered as HTML. It's built on the well‑maintained
`league/commonmark` library and offers three flavors of Markdown, from plain
CommonMark up to GitHub‑flavored Markdown with tables, task lists, footnotes, and
more. If you want a lightweight Markdown option — for a body field, comments, or
user‑generated content — without a full WYSIWYG editor, this is it.

It's designed with security in mind. Markdown Easy converts the Markdown to HTML,
and then core's **"Limit allowed HTML tags"** filter sanitizes that HTML against an
allow‑list. By default the converter also strips raw embedded HTML and dangerous
links. The one rule to remember is **ordering**: Markdown Easy must run *before* the
"Limit allowed HTML tags" filter on the format. The module actively enforces this —
it will show an error if you configure a format where that filter is missing or
ordered wrong, and it warns you about HTML tags your chosen flavor produces that
aren't yet allowed. There's even a ready‑made **markdown** text format you can import
that's already wired up correctly.

There is no standalone settings page. You configure Markdown Easy per text format,
where its only per‑format option is the **flavor**. A small site‑wide config object
holds two advanced "escape hatch" settings for special pipelines, which you should
normally leave alone.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. You enable and configure the filter on text
formats at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

### Add the filter to a text format

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   (or create) a text format — for example a "Markdown" format for body fields.
2. In the **Enabled filters** list, tick **Markdown Easy**.
3. Make sure **"Limit allowed HTML tags and correct faulty HTML"** is also enabled.
4. Under **Filter processing order**, drag **Markdown Easy** to run *before*
   "Limit allowed HTML tags". This ordering is required — the module will block you
   with an error if you get it wrong, which is a feature, not a nuisance.
5. In the **Markdown Easy** filter settings, choose a **flavor**:
   - **Standard** — plain CommonMark.
   - **GitHub** — adds autolinks, strikethrough, tables, and task lists.
   - **Markdown Smörgåsbord** — GitHub plus footnotes and description lists.
6. If the module warns that your allowed‑HTML list is missing tags the flavor
   produces (like `<table>` or `<del>`), add those tags to the "Limit allowed HTML
   tags" filter so they aren't stripped from the output.
7. **Save** the format. Content written with that format is now rendered from
   Markdown.

### Or import the ready‑made format

The module ships an optional **markdown** text format that already has Markdown Easy
and the HTML sanitizer wired in the correct order. It installs automatically when the
conditions are met, giving you a correct starting point without hand‑configuring the
filters.

### Advanced site‑wide settings

Two escape‑hatch settings exist in the `markdown_easy.settings` config object, and
the secure default is to leave both off:

- **Skip filter enforcement** — turns off the ordering checks. Only for advanced
  pipelines where you take responsibility for correctness.
- **Skip HTML input stripping** — lets raw HTML in the source pass through the
  converter. Only safe on a trusted format that still runs the HTML sanitizer
  afterward.

> Do not enable Markdown Easy on a format available to untrusted users without the
> "Limit allowed HTML tags" filter running after it — that filter is the real
> sanitizer.

Developers can extend the CommonMark converter via
`hook_markdown_easy_config_modify()` and
`hook_markdown_easy_environment_modify()`.
