<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter: `prism_filter` — "Highlight code using prism.js"

`src/Plugin/Filter/PrismFilter.php`. Type: `TYPE_TRANSFORM_REVERSIBLE`.
Default settings: `always_include_prism_library = FALSE`.

## Enable

Admin → Configuration → Content authoring → Text formats and editors → (a format) → enable
**"Highlight code using prism.js"**. Optionally tick **"Always include Prism.js library"** to attach
the assets on every rendering of that format (needed if authors write raw
`<pre><code class="language-*">` HTML rather than `[prism:]` tags).

## Two input syntaxes

1. **`[prism:LANGUAGE]` tags** (module-specific):

   ```
   [prism:css]
   a { color: #7BC673; }
   [/prism:css]
   ```

   Becomes:

   ```html
   <div class="prism-wrapper" rel="css"><pre><code class="language-css">…escaped code…</code></pre></div>
   ```

   A wrapper is emitted only when a matching `[/prism:LANGUAGE]` close tag exists. The code between
   the tags is HTML-escaped with `Html::escape()`.

2. **Existing `<code>` tags** — if the incoming text already contains a `<code` substring the filter
   attaches the Prism library so those blocks highlight. Prism only highlights `<code>` elements that
   carry a `language-*` class, so this is what makes ```` ``` ```` Markdown fences work when the
   Markdown filter runs first and produces `<pre><code class="language-*">`.

## Ordering

Place any filter that *produces* code blocks (Markdown, code-fence filters) **before** this filter,
so the `<code>` tags exist by the time Prism's filter runs.

## What it does NOT do

- It does not itself parse Markdown; it only reacts to `<code>` already in the text.
- It adds no line-numbers / copy-button / diff behaviour beyond what your downloaded Prism bundle
  contains.
- It requires `/libraries/prism/prism.js` + `prism.css` to be installed (see start.md).
