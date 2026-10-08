# Improve Line Breaks Filter — manual setup guide

**Improve Line Breaks Filter** (`improve_line_breaks_filter`) is a small text-format
filter that cleans up the **empty paragraphs** a WYSIWYG editor leaves behind. When
editors press Enter in CKEditor they often create markup like `<p></p>` or
`<p>&nbsp;</p>`, which shows up as unwanted vertical gaps on the page. This filter
turns each of those empty paragraphs into a simple `<br />` line break — or, if you
prefer, removes them entirely.

Like every Drupal text filter, you switch it on per **text format** (Basic HTML,
Full HTML, and so on) rather than from a global settings page. It has a single
option, **Remove empty paragraphs**: leave it off to replace each empty paragraph
with a `<br />` (preserving the intended single-line spacing), or turn it on to
delete empty paragraphs outright for tighter output.

It is careful about what it touches. Before making any changes it sets aside the
contents of `<pre>`, `<code>`, `<script>`, `<style>`, `<object>`, and `<iframe>`
tags (and HTML comments), so code samples and preformatted blocks are never
rewritten. It only ever affects genuinely *empty* paragraphs — paragraphs with real
content and existing `<br>` tags are left alone. It is an output-time transform, so
your stored content is not modified; only the rendered HTML is cleaned.

There is no admin settings page, no permissions, and no Drush commands. It depends
only on core's **Filter** module.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the exact matching regex
and skip list — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The filter is turned on per text format:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** on the format you want to clean up (for example **Basic
   HTML** or **Full HTML**).
3. Under **Enabled filters**, tick **Improve line breaks**.
4. Under **Filter processing order**, drag **Improve line breaks** toward the end of
   the list, so filters that need to run first (like HTML correction) do so before
   it.
5. On the **Improve line breaks** tab in **Filter settings**, choose the behavior:
   - Leave **Remove empty paragraphs** unticked to replace each empty paragraph with
     a `<br />`.
   - Tick **Remove empty paragraphs** to delete empty paragraphs entirely.
6. Click **Save configuration**.

The setting is stored inside that format's own configuration, so it exports and
deploys with the rest of your config. Repeat for each format where WYSIWYG editors
tend to leave stray empty paragraphs. Because the change happens at render time, you
will see the effect on displayed content immediately (clear caches if needed) —
existing stored values are untouched.
