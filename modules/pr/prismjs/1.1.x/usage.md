<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prism Js syntax highlighter (`prismjs`) gives CKEditor 5 a toolbar button that opens a dialog where an editor pastes source code and picks a language; the code is stored on a custom `<prism-js>` element, and a bundled text-format filter later rewrites that element into PrismJS `<pre><code class="language-X">` markup with the highlighter's CSS/JS attached. All PrismJS assets (eight themes) ship locally.

---

This module is a self-contained CKEditor 5 integration, not a generic library loader — do not confuse it with the separate `prism` project. Its parts: a **CKEditor 5 plugin** (`Drupal\prismjs\Plugin\CKEditor5Plugin\PrismJs`) that adds a toolbar button and registers a `prismJs` model element downcast to a `<prism-js>` tag carrying `data-plugin-id` and `data-plugin-config` attributes; a **dialog form** (route `prismjs.dialog`) where the editor selects a language and types code, producing a JSON `{language, text}` payload stored in `data-plugin-config`; a **preview controller** (route `prismjs.preview`, gated by `use text format X`) that renders a live preview inside the editor; and the load-bearing piece, a **text-format filter** `prismjs` (`TYPE_TRANSFORM_REVERSIBLE`, weight 100) that scans saved output for `<prism-js>…</prism-js>` blocks, decodes the `data-plugin-config` JSON, HTML-escapes the code text, and emits `<pre data-src="prism.js" class="language-{language}"><code class="language-{language}">{text}</code></pre>`, attaching `prismjs/prismjs.{theme}` and `prismjs/prismjs.custom`. Because the language is chosen explicitly in the dialog (not detected from content), the editor and renderer always agree. A settings form at `/admin/config/content/prism-js` (`administer prismjs configuration`) picks which of ~297 languages appear in the dialog and the default theme (default/dark/funky/okaidia/twilight/coy/solarized-light/tomorrow-night). To use it you must enable CKEditor 5 on a format, drag the Prism Js button onto the toolbar, enable the "Prism Js" filter, and — unless the format is Full HTML — allow `<pre>`, `<code>`, and the `class` attribute in the "Limit allowed HTML tags" filter. There is no CDN option, no copy-to-clipboard button, and no line-numbers configuration in this version; everything is local and the filter output is plain Prism markup.

---

- Insert a syntax-highlighted code block into a CKEditor 5 body field.
- Let an editor choose the code language from a dialog dropdown.
- Highlight PHP, JavaScript, SQL, YAML, or shell examples in an article.
- Publish a developer tutorial with coloured code samples.
- Show a configuration example (`.ini`, `.yml`, `nginx`) in documentation.
- Add API request/response snippets to a knowledge-base page.
- Restrict the editor's language list to only the languages a site actually uses.
- Pick a Prism color theme site-wide (e.g. Tomorrow Night) from the settings form.
- Give non-admin editors code insertion without granting extra permissions (dialog-driven).
- Render a live preview of a code block while still editing in CKEditor 5.
- Serve the highlighter's CSS/JS locally rather than from a third-party CDN.
- Standardise code presentation across a team's authored content.
- Display a diff or log snippet with Prism's `diff`/`log` grammar.
- Highlight a Twig or Markdown template example in a how-to.
- Show Dockerfile or docker-compose examples in an ops runbook.
- Add a Solidity/Rust/Go snippet to a technical blog post.
- Keep code presentation consistent between the editor preview and the published page.
- Switch the whole site's code styling by changing one theme setting.
- Provide a reversible filter so the source `<prism-js>` element round-trips back into the editor.
- Document shell commands in an installation guide.
