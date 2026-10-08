<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prism integrates the Prism.js syntax highlighter with Drupal, rendering code blocks as `<pre><code class="language-*">` highlighted by language, through either a text-format filter or a dedicated code field.

---

The module gives you two independent, non-overlapping tools and it is worth knowing which one to reach for. The **`prism_filter` text filter** ("Highlight code using prism.js") is enabled on a text format. It rewrites custom `[prism:php]...[/prism:php]` blocks (the code inside is HTML-escaped by the filter) into `<pre><code class="language-php">` markup and attaches the Prism assets; it also detects any existing `<code>` tags in the text — for example the `<pre><code class="language-*">` a Markdown filter produces from triple-backtick fences — and attaches the library so those are highlighted too, provided the `<code>` carries a `language-*` class. Filter ordering matters: run Markdown (or any filter that produces code blocks) **before** the Prism filter. A per-format "Always include Prism.js library" setting forces the JS/CSS onto every rendered page even when no code block is present, which is what you want if authors write raw `<pre><code class="language-*">` HTML rather than `[prism:]` tags. The second tool is the **`text_long_prism` field** — a field type with a textarea widget plus a language `<select>` and a `prism_default` formatter; add it to any fieldable entity to store one code snippet plus its language and render it highlighted, without touching any text format. The languages offered in that select are curated at `/admin/config/content/prism/settings`. Crucially, the module ships **no library**: download `prism.js` and `prism.css` from prismjs.com/download.html (customise the language/theme bundle there), drop them in `/libraries/prism/`, and a `hook_requirements` check will confirm they are present. Assets are always local — there is no CDN option, and no line-numbers/copy-button/diff plugins are added beyond whatever you bake into your downloaded bundle.

---

- Highlight fenced code blocks authored in Markdown (Markdown filter first, Prism filter after).
- Highlight code wrapped in custom `[prism:language]...[/prism:language]` tags inside a rich-text body.
- Highlight raw `<pre><code class="language-*">` HTML that authors paste into a WYSIWYG.
- Add a dedicated "code snippet + language" field to an article or documentation content type.
- Store a single reusable command/config example on an entity via the `text_long_prism` field.
- Force the Prism assets onto every page of a format so hand-written code blocks always highlight.
- Restrict which languages content authors may pick in the code-field widget.
- Publish a developer tutorial with per-block language highlighting.
- Colour shell commands and configuration examples in a knowledge base.
- Present an API request/response pair with correct language classes.
- Highlight SQL, PHP, or Twig examples inside a technical blog post.
- Ship a customised Prism bundle (only the languages/theme the site uses) from `/libraries/prism/`.
- Highlight code inside comment bodies by enabling the filter on the comment format.
- Re-highlight code that arrives via AJAX (the module's JS re-runs `Prism.highlightAll()` on attach).
- Keep highlighting assets local (no third-party CDN request) for CSP/privacy reasons.
- Give a training site language-tagged code samples authors can maintain in a plain textarea.
- Combine the field (for a canonical snippet) with the filter (for inline examples) on the same content type.
- Swap the visual theme by replacing the downloaded `prism.css` without changing Drupal config.
- Support additional languages later by re-downloading a wider Prism bundle into `/libraries/prism/`.
- Document configuration/YAML examples with a `yaml` language class.
