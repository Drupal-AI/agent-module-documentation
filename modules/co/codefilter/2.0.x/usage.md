<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Code Filter is a text-format filter that turns `<code>...</code>` and `<?php ... ?>` blocks in content into escaped, formatted code — generic `<code>` blocks are HTML-escaped and rendered verbatim, and `<?php ... ?>` blocks get PHP syntax highlighting via PHP's `highlight_string()`.

---

Publishing code in a CMS is a fight between the code sample and the filter chain: angle brackets are stripped or interpreted, an editor's autocorrect mangles quotes, and a snippet that was correct in the field is wrong on the page — which on a documentation site is not cosmetic, because a reader copies what they see. Code Filter takes the direct approach. It registers a single `@Filter` plugin (id `codefilter`, type `TYPE_MARKUP_LANGUAGE`). In the filter **prepare** phase it finds `<code>...</code>`, `<?php ... ?>` and `[?php ... ?]` blocks and runs their contents through `Html::escape()` (htmlspecialchars), stashing each block behind an internal `[codefilter_code]` / `[codefilter_php]` sentinel so that no other filter — including "Limit allowed HTML tags" — touches the code body. In the **process** phase it converts the sentinels back to HTML: a generic `<code>` block becomes an inline `<code>` element, or, when multiline, a `<div class="codeblock"><code>…</code></div>`; a `<?php ... ?>` block is decoded and re-highlighted with `highlight_string("<?php…?>", 1)`, which emits PHP's own color `<span>`s and — importantly — HTML-escapes the code as it goes. The result is attached to the `codefilter/codefilter` library (a small CSS file styling `div.codeblock`, plus an optional jQuery "expand on hover" behaviour enabled by the per-format `nowrap_expand` setting). The security point is worth stating plainly because it is the opposite of what "filter" sometimes implies: **this filter's job is escaping, and escaping is what makes it safe** — a `<script>` inside a code sample is shown as literal text, never executed. That safety depends on filter **order**, and the module enforces it: a `hook_form_filter_format_edit_form_alter` validator refuses to save a format unless "Correct faulty and chopped off HTML" (filter_htmlcorrector) is enabled and ordered after codefilter, "Limit allowed HTML tags" (filter_html) is ordered before it, and "Convert line breaks into HTML" (filter_autop) is ordered after it. The module is one of the oldest in the ecosystem (originally core in Drupal 6, split out by Steven Wittens), its `^8 || ^9 || ^10 || ^11` range reflecting a job that has not changed. Version **2.0.1**, no module dependencies, PHP >= 8.1.6.

---

- Publish a code sample safely without manual `&lt;`/`&gt;` escaping.
- Show a PHP snippet with syntax colouring in an article.
- Escape angle brackets in documentation so `<script>` displays as text.
- Prevent a code sample being interpreted as page markup.
- Keep a copied snippet correct on a documentation site.
- Publish a configuration or YAML example.
- Show a shell command in a tutorial.
- Document an API call with an inline `<code>` tag.
- Escape a Twig or HTML template example.
- Add a code-safe text format for a forum or Q&A section.
- Show XML or HTML source as literal text.
- Prevent WYSIWYG autocorrect from breaking quotes in code.
- Publish a changelog containing code snippets.
- Show a regular expression without it being mangled.
- Highlight a `<?php ... ?>` function example on a handbook page.
- Escape user-submitted code samples in comments.
- Publish a knowledge-base article with mixed prose and code.
- Show a SQL query inside a `<code>` block.
- Combine with a syntax highlighter, confirming it runs on the escaped output.
- Wire a code format into the correct filter order (filter_html before; autop and htmlcorrector after).
- Enable "expand on hover" for wide, non-wrapping code blocks.
- Render both inline `<code>` and block-level multiline code from the same tag.
