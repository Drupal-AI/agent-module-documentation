<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Code Filter (codefilter) — agent index

Text-format filter that turns `<code>...</code>` and `<?php ... ?>` blocks into **escaped, formatted**
code. Single `@Filter` plugin (id `codefilter`, `TYPE_MARKUP_LANGUAGE`). No module dependencies.
Version **2.0.1**, PHP >= 8.1.6, core `^8 || ^9 || ^10 || ^11`. Originally Drupal-6 core, split out
by Steven Wittens; used on drupal.org.

## What it actually does (read the source, not the old stub)

- **Tags handled:** `<code>...</code>` (generic), and `<?php ... ?>` / `[?php ... ?]` (PHP).
- **Generic `<code>`** → HTML-escaped via `Html::escape()`, rendered as inline `<code>` or, when
  multiline, `<div class="codeblock"><code>…</code></div>`. (Not `<pre>`.)
- **`<?php ... ?>`** → **PHP syntax highlighting via `highlight_string()`**, wrapped in
  `<div class="codeblock">`. **Yes, it highlights** — colour `<span>`s come from PHP itself.
  (Inline `<?php…?>` found *inside* a `<code>` block is also highlighted.)
- **Two-phase design:** `prepare()` escapes each block's body and hides it behind
  `[codefilter_code]` / `[codefilter_php]` sentinels so other filters can't touch the code; `process()`
  turns the sentinels back into HTML and returns a `FilterProcessResult`, attaching the
  `codefilter/codefilter` library (CSS for `div.codeblock` + optional jQuery hover-expand).
- **Per-format setting:** `nowrap_expand` (boolean) — adds `nowrap-expand` class so wide blocks
  expand on hover instead of wrapping.
- **Filter-order enforcement** (`codefilter.module`, `hook_form_filter_format_edit_form_alter`): the
  format won't save unless **filter_htmlcorrector** is enabled and after codefilter, **filter_html**
  (if used) is before codefilter, and **filter_autop** (if used) is after codefilter.

## The security point

**This filter's job is escaping, and the escaping is what makes it safe.** Content between the tags
becomes **text** — a `<script>` in a sample is displayed, not executed. Generic code is escaped with
`Html::escape()`/htmlspecialchars; PHP is escaped by `highlight_string()`. The `Html::decodeEntities()`
calls are only ever handed straight to `highlight_string()`, which re-escapes. Safe operation depends
on **filter order**, which the module enforces (see above).

## Files
- `data.json` — metadata.
- `usage.md` — one-liner / mechanism paragraph / use-case bullets.
- `agent/filters/codefilter.md` — the filter plugin in detail.
