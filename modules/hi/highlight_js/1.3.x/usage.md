<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Highlight Js syntax highlighter adds a code-block button to CKEditor 5 and a text-format filter that renders those blocks with the Highlight.js library, including an optional copy-to-clipboard button.

---

The module has two halves that work together. On the editing side it registers a CKEditor 5 plugin (`highlightJs`) that adds a toolbar button; clicking it opens a modal dialog (`/highlight-js/dialog/{uuid}`, gated by `use text format advanced`) where the author picks a language from the site-configured list and pastes source code, and CKEditor stores that as a `<highlight-js data-plugin-id data-plugin-config="…json…">` element in the body. On the display side a text filter (`@Filter` id `highlight_js`, `TYPE_TRANSFORM_REVERSIBLE`, weight 100) rewrites each `<highlight-js>` element into `<pre class="language-X"><code class="language-X">…</code></pre>`, HTML-escaping the code text, and attaches two front-end libraries: `highlight_js.custom` (which pulls `highlight.min.js` 11.9.0 and `clipboard.min.js` 2.0.8 from cdnjs.cloudflare.com) and the selected theme's stylesheet (`highlight_js.style-<theme>`, also from cdnjs — over 380 Highlight.js themes are declared). Client JS then calls `hljs.highlightElement()` on every `<code>` element and, when enabled, injects a Clipboard.js copy button. Administration lives at `/admin/config/content/highlight-js` (`HighlightJsSettingsForm`, permission `administer highlight_js configuration`, which is correctly `restrict access: TRUE`): choose which languages appear in the dialog, pick the default theme (config default `github`; the filter's hard-coded fallback is `3024`), and configure the copy button (colors, label text, success text, and optional per-role access). The `highlight_js.settings` config object holds all of it, with a config schema. Note that every asset (library JS and every theme CSS) is loaded from the CDN with `type: external` and **no** Subresource Integrity hash, so the site takes a third-party runtime dependency on cdnjs on any page that shows a code block. The module also defines its own small plugin type (`@HighlightJs`) with a single `language_select` plugin used for the in-editor preview at `/highlight-js/preview/{editor}`.

---

- Add a syntax-highlighted code block inside CKEditor 5.
- Let content editors insert source code without needing Full HTML.
- Render `<highlight-js>` authored blocks as themed `<pre><code>`.
- Publish highlighted code on a documentation site.
- Choose which languages appear in the editor's code dialog.
- Restrict the language list to only the ones a site publishes.
- Pick a site-wide Highlight.js theme from 380+ options.
- Show a copy-to-clipboard button on code blocks.
- Style the copy button's colors and label text.
- Limit the copy button to specific user roles.
- Enable a per-block role-restricted copy button from the dialog.
- Display PHP, JavaScript, YAML, SQL, Bash, and 240+ other languages.
- Highlight a shell command or configuration example clearly.
- Add code display to a developer blog or knowledge base.
- Show a diff or an API request/response in an article.
- Present a code-heavy changelog or tutorial.
- Preview a code block inside the CKEditor dialog before inserting.
- Match the code theme to a light or dark site design.
- Give a training site formatted, readable code samples.
- Integrate Highlight.js 11.9.0 without hosting the library yourself.
