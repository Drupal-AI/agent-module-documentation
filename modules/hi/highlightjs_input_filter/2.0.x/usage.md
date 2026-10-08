highlight.js Input Filter adds a "Highlight code using highlight.js" text-format filter that attaches the highlight.js library and its assets whenever content contains `<pre><code class="language-*">` blocks, giving client-side syntax highlighting with an optional copy-to-clipboard button.

---

The module ships a single filter plugin (`filter_highlightjs`, a reversible transform filter) that you enable on any text format. On render, `HighlightJs::process()` scans the text with a regex for `<pre><code class="…language-X…">` blocks, collects the declared languages (resolving common aliases like `js`→`javascript`, `html`→`xml`), and attaches the `highlightjs_input_filter/highlightjs` asset library plus `drupalSettings` (`highlightJsLanguages`, `highlightJsBaseUrl`, `enableCopyButton`); the bundled `js/highlightjs_input_filter.js` ES module then loads the matching highlight.js language modules and initializes highlighting in the browser. It does not rewrite the code markup — it only attaches assets, so the code you author is what gets highlighted. A settings form at `admin/config/content/highlightjs_input_filter` (permission `administer highlightjs_input_filter settings`) picks the highlight.js CSS theme (200+ options such as `atom-one-dark`), toggles the copy button, and switches between the default unpkg.com CDN (highlight.js 11.11.1) and a self-hosted `/libraries/highlightjs` copy. The chosen theme CSS is attached dynamically via `hook_library_info_build`; `hook_library_info_alter` swaps the copy-plugin assets to local paths when self-hosting; and `hook_runtime_requirements` warns on the status report if local libraries are enabled but missing. Designed for the ES-module distribution of highlight.js (not the single-file custom builds from highlightjs.org/download).

---

- Add client-side syntax highlighting to `<pre><code>` code blocks in body/rich-text fields.
- Enable the highlight.js filter on a Full HTML or custom text format used for documentation.
- Highlight code samples authored in CKEditor 5 code blocks (`language-*` class).
- Pick a syntax-highlighting color theme (e.g. `atom-one-dark`, `github-dark`, `monokai`) site-wide.
- Show a hover copy-to-clipboard button on every highlighted code block.
- Serve highlight.js from the unpkg.com CDN with zero local setup (default).
- Self-host highlight.js assets from `/libraries/highlightjs` for privacy, offline, or restricted-network sites.
- Self-host the highlightjs-copy plugin from `/libraries/highlightjs-copy/dist`.
- Support many languages automatically by reading the `language-<id>` class on each block.
- Rely on alias resolution so `class="language-js"`, `language-html`, or `language-cs` load the right highlight.js grammar.
- Provide a consistent code-presentation style across a multi-author documentation site.
- Get a status-report error when "use local libraries" is on but the files are missing.
- Add code highlighting to a blog's technical posts without writing custom JS.
- Highlight configuration snippets (YAML, JSON, bash) in knowledge-base articles.
- Manage the JS libraries via Composer + Asset Packagist for reproducible builds.
- Switch a documentation site from a light to a dark code theme by changing one setting.
- Keep highlighting purely client-side (no server-side markup transformation of the code).
- Cache highlighting decisions with the config object (filter output depends on the settings config's cache tags).
- Restrict who can change the theme/library settings via the module's dedicated permission.
