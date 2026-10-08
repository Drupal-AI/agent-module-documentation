Highlight PHP is a text-format filter that server-side syntax-highlights the contents of `<code>` tags in rendered HTML using the PHP port of highlight.js (`scrivo/highlight.php`), producing `hljs`-classed markup styled by a bundled a11y theme.

---

Despite the name, the module does NOT execute PHP — it is a syntax highlighter, not an evaluator. It defines one filter plugin, `filter_highlight_php` ("Highlight &lt;code&gt; tags in HTML."), that you enable on a text format. When content is rendered, the filter loads the HTML, walks every `<code>` element via `DOMXPath`, and runs the highlighter over each element's text content. In `auto` mode it calls `highlightAuto()` restricted to a configurable language whitelist; in `manual` mode it reads the language from the `<code>` tag using a configurable regex (default `language-([a-zA-Z1-9]*)`, matching CKEditor's `language-*` class) and calls `highlight($language, $code)`. The highlighter emits escaped `<span class="hljs-...">` markup, which is re-inserted as a document fragment and the `hljs` + detected-language classes are added to the tag. A global settings form at `/admin/config/content/highlight-php` (permission `administer site configuration`) stores `mode`, `auto_languages`, and `manual_regex` in `highlight_php.settings`. The module also registers a Twig filter `|highlight` that highlights an arbitrary string (passed through `Xss::filterAdmin`). Styling comes from the `highlight_php/main` library (`css/a11y-light.css` + `css/main.css`), attached automatically whenever highlighting occurs. Pairs with a CKEditor "Code block" button so editors can mark code regions.

---

- Add server-side syntax highlighting to code samples in body/rich-text fields without a client-side highlight.js build.
- Highlight fenced code entered via CKEditor's "Code block" plugin (which wraps code in `<pre><code class="language-xxx">`).
- Auto-detect the language of a code snippet from a restricted whitelist (`html php javascript css twig yaml go protobuf sql` by default).
- Restrict auto-detection to only the languages your site actually uses, improving guess accuracy.
- Switch to manual mode so the language is taken from the `<code>` tag's class instead of being guessed.
- Customize the manual-mode regex to match a non-default class convention (e.g. `lang-([a-z]+)`).
- Ship a consistent, accessible (a11y-light) code theme across all formatted text.
- Highlight PHP, Twig, YAML, or SQL snippets in technical documentation nodes.
- Provide highlighted code in comments or other filtered text by enabling the filter on that format.
- Render highlighted code in a Twig template via the `{{ some_code|highlight }}` filter.
- Highlight a code string built in a custom preprocess/controller and print it safely in a template.
- Give a blog or knowledge base readable, colored code blocks with zero editor-side configuration.
- Ensure highlighting is applied at render time (cacheable) rather than on every page load in JavaScript.
- Keep highlighting output escaped/safe — the module emits span markup, never executes the code.
- Apply highlighting only to trusted formats by enabling the filter selectively per text format.
- Combine with a filter order so highlighting runs after HTML is assembled but the `<code>` tags survive.
- Support multiple languages in a single document, each `<code>` block detected independently.
- Migrate from a JS-only highlighter to server-rendered highlighting for better performance/SEO.
- Present configuration/code examples in help or documentation pages with proper coloring.
- Style highlighted output further with site CSS targeting `.hljs` and `hljs-*` token classes.
