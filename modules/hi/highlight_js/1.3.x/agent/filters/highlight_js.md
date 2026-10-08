<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `highlight_js` text filter

**Plugin:** `src/Plugin/Filter/HighlightJs.php` — `@Filter(id = "highlight_js")`,
`type = TYPE_TRANSFORM_REVERSIBLE`, `weight = 100`, `@internal`.
**Enable it** on a text format at `/admin/config/content/formats`. The CKEditor 5 `highlightJs`
toolbar button has `conditions: { filter: highlight_js }`, so the button only appears when this
filter is on.

## What `process()` does
1. Scans the text for `<code>…</code>` (`$code_added`) and for
   `<highlight-js>…</highlight-js>` (`$highlight_enabled`). If neither is present it returns the text
   untouched and attaches nothing.
2. For each `<highlight-js>` element it reads the `data-plugin-config="…"` attribute (via the
   `getStringBetween()` helper), `html_entity_decode()`s it and `json_decode()`s it to get:
   - `text` — the source code. Emitted as `htmlspecialchars($source_code->text)` (escaped).
   - `language` — emitted **raw** into `class="language-<language>"` on both `<pre>` and `<code>`.
   - `role_based_copy` / `role_copy_access` — per-block copy-button gating.
3. Replaces the element with:
   ```html
   <pre data-src="highlight.js" class="language-<lang>"><code class="language-<lang>" copy-enabled|copy-disabled>…escaped text…</code></pre>
   ```
   `copy-enabled` vs `copy-disabled` is decided from the global `copy_enable` config plus the
   block's / global role list intersected with the current user's roles.
4. A handful of legacy composite language keys are normalised, e.g.
   `bash, sh, zsh → bash`, `tcl, tk → tcl` (mirrors update hook `highlight_js_update_11002`).

## Libraries & settings attached
Whenever a code block is present the filter attaches:
- `highlight_js/highlight_js.custom` → depends on `highlight_js/highlight_js.js`, which loads
  **`highlight.min.js` 11.9.0 and `clipboard.min.js` 2.0.8 from cdnjs.cloudflare.com** (external, no
  SRI). `highlight-custom.js` calls `hljs.highlightElement()` on every `<code>` and adds the copy
  button.
- `highlight_js/highlight_js.style-<theme>` — the theme stylesheet, also from cdnjs.
  `$theme = config('theme') ?? '3024'` (note: config default is `github`, so `3024` is only used
  when the key is truly unset).
- `drupalSettings.button_data` — copy-button colors/labels (with hard-coded fallbacks
  `#4243b1` / `#ffffff` / `Copy` / `Copied!`).

## Markup contract for authored content
For the filter to produce output the format must allow the `<highlight-js>` element (added by the
CKEditor plugin's `elements` list) and, for the rendered result, `<pre>`, `<code>`, and the `class`
attribute. Bare `<code>` blocks with no `<highlight-js>` wrapper still get client-side
`hljs.highlightElement()` and library attachment (because `$code_added` triggers attachment), but
are not rewritten server-side.

## Notes for agents
- The code **text** is passed through `htmlspecialchars()`; the emitted `class="language-<lang>"`
  value comes straight from the stored `data-plugin-config` JSON.
- `TYPE_TRANSFORM_REVERSIBLE` + weight 100 means it runs late; put "Limit allowed HTML tags"
  earlier and make sure it does not strip `<highlight-js data-plugin-config data-plugin-id>`.
