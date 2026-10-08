<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter plugin: `codefilter`

Class: `Drupal\codefilter\Plugin\Filter\CodeFilter` (`src/Plugin/Filter/CodeFilter.php`), extends
`FilterBase`.

```
@Filter(
  id = "codefilter",
  module = "codefilter",
  title = "Code filter",
  type = TYPE_MARKUP_LANGUAGE,
  settings = { "nowrap_expand" = 0 }
)
```

## Tags recognised
- `<code>...</code>` — generic code, escaped and rendered verbatim.
- `<?php ... ?>` and `[?php ... ?]` — PHP code, escaped and **syntax-highlighted**.

## Pipeline

### `prepare($text, $langcode)` — runs in the prepare phase (before other filters' process)
- `@<code>(.+?)</code>@s` → `self::escape($1, 'code')`.
- `@[\[<](\?php)(.+?)(\?)[\]>]@s` → `self::escape($php_body, 'php')` (matches both `<?php…?>` and
  `[?php…?]`).
- `escape()`: `Html::escape(str_replace('\"', '"', $text))` (htmlspecialchars), then protects
  newlines (`\r`→'', `\n`→`&#10;`), then wraps as `[codefilter_code]…[/codefilter_code]` or
  `[codefilter_php]…[/codefilter_php]`. These sentinels shield the code body from every downstream
  filter (e.g. filter_html cannot strip tags that are now escaped text hidden in a sentinel).

### `process($text, $langcode)` — returns `FilterProcessResult`
- `[codefilter_code]…[/codefilter_code]` → `processCode()`:
  - restore newlines, strip stray `<br>`/`<p>`, `nl2br()`, wrap in `<code>`; multiline gets
    `<div class="codeblock">…</div>`; spaces → `&nbsp;` then `fixSpaces()`.
  - inline `&lt;?php…?&gt;` found inside the code is highlighted via `processPhpInline()`
    (`highlight_string(Html::decodeEntities($text), 1)`).
- `[codefilter_php]…[/codefilter_php]` → `processPhp()`:
  - `Html::decodeEntities()` then `highlight_string("<?php\n$text\n?>", 1)`, wrapped in
    `<div class="codeblock">`; normalises `<br />`→`<br>`; `fixSpaces()`.
- If `nowrap_expand` is on, `class="codeblock"` → `class="codeblock nowrap-expand"`.
- Attaches library `codefilter/codefilter`.

### `tips($long)`
Short: "You may post code using `<code>...</code>` (generic) or `<?php ... ?>` (highlighted PHP) tags."
Long adds that PHP is colourised by syntax.

## Settings
- `nowrap_expand` (checkbox, default 0): "Expand code boxes on hover." Code boxes normally inherit the
  theme's wrapping; with this on they don't wrap but expand to full width on hover (JS in
  `codefilter.js`, requires `core/jquery`).

Config schema: `filter_settings.codefilter` → `nowrap_expand: boolean` (`config/schema/codefilter.schema.yml`).

## Required filter ordering (enforced by `codefilter.module`)
`codefilter_form_filter_format_edit_form_validate()` blocks saving a format when:
- **filter_htmlcorrector** is not enabled (it is required), or is weighted *before* codefilter
  (must be after — needed to fix truncated summary output).
- **filter_html** (if enabled) is weighted *after* codefilter (must be before, so the HTML produced
  for PHP code is not stripped).
- **filter_autop** (if enabled) is weighted *before* codefilter (must be after, for correct line
  breaks).

Recommended chain: Limit allowed HTML → **Code filter** → Convert line breaks → Correct faulty HTML.

## Security
The whole point of the filter is safe escaping. Generic `<code>` bodies are escaped with
`Html::escape()`; `<?php ... ?>` bodies are escaped by `highlight_string()`. Every `decodeEntities()`
call is immediately re-escaped by `highlight_string()`. `<script>` and other markup inside a code
block are rendered as literal text, not executed. Output is marked safe (`FilterProcessResult`) as
normal for a filter; the enforced ordering keeps filter_html ahead so non-code markup is still
sanitised by that filter.
