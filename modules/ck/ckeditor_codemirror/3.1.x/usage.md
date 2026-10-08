<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor CodeMirror replaces the plain textarea of CKEditor 5's "Source" view with a CodeMirror 5 editor, giving editors syntax highlighting, line numbers, bracket/tag matching, code folding and search while they edit raw HTML.

---

The module ships a single CKEditor 5 plugin, `ckeditor_codemirror_source_editing`, that decorates core's Source editing plugin. It is configured **per text format** — there is no global settings page and `configure` in the info file is unset. On a text format's edit screen (`/admin/config/content/formats/manage/{format}`), once the **Source** button is in the toolbar, a "CodeMirror source editing" vertical tab appears with an *Enable* checkbox, a syntax **Mode** select (HTML mixed, HTML only, PHP, JavaScript, CSS, SCSS) and nine boolean options (auto-close brackets/tags, folding, line numbers, line wrapping, match brackets/tags, search bar at bottom, highlight active line). Those values are stored in the `editor.editor.{format}` config entity under `settings.plugins.ckeditor_codemirror_source_editing`. The plugin declares `conditions: {plugins: {ckeditor5_sourceEditing}}`, so it is only offered — and only loads — when the format's toolbar actually contains `sourceEditing`. At render time `getDynamicPluginConfig()` translates the stored options into a CodeMirror options object (adding `gutters`, `foldGutter`, `search.bottom` and an `Alt-F` find-persistent key binding) which is handed to the `sourceEditingCodemirror.SourceEditingCodeMirror` JS plugin. Two external JS libraries must be present under the docroot `libraries/` directory — CodeMirror **5** (v6 is not supported) and `@cdubz/ckeditor5-source-editing-codemirror` — and `hook_requirements()` reports their presence and version on the status report. A `CKEditor4To5Upgrade` plugin migrates old CKEditor 4 `codemirror` settings to the new key.

---

- Give editors syntax-highlighted HTML in CKEditor 5's Source view instead of a raw textarea.
- Show line numbers in the source editor so editors can talk about "line 42" of a body field.
- Enable code folding so long HTML blocks can be collapsed while editing.
- Highlight matching brackets and tags to catch unbalanced markup before saving.
- Auto-close HTML tags and brackets while typing raw markup.
- Turn on line wrapping so wide markup does not scroll horizontally.
- Add a persistent search bar (Alt-F) to find text inside a long HTML source.
- Highlight the active line to keep an editor's place in a long document.
- Configure a "Developer" text format with CodeMirror enabled while leaving Basic HTML untouched.
- Switch the highlighting mode to CSS for a format used to edit stylesheet snippets.
- Switch the highlighting mode to SCSS (`text/x-scss`) for a design-system documentation format.
- Use the PHP mode (`application/x-httpd-php`) for a format that stores mixed PHP/HTML samples.
- Use JavaScript-only mode for a format used to paste script blocks.
- Deploy per-format editor settings through exported `editor.editor.*` config in a config-first workflow.
- Audit which text formats have CodeMirror turned on by reading `settings.plugins.ckeditor_codemirror_source_editing.enable`.
- Force the Source button into a toolbar as a prerequisite so the CodeMirror tab becomes available.
- Migrate a CKEditor 4 site's `codemirror` plugin settings automatically during the CKEditor 5 upgrade.
- Verify the CodeMirror 5 library is installed and at which version from the site status report.
- Provide a friendlier markup-editing experience for content editors who occasionally drop into Source view.
- Reduce copy/paste markup errors in landing-page bodies by making structure visible.
- Let support staff inspect embedded iframe/script markup safely in a highlighted view.
- Standardise source-editing ergonomics across several editorial text formats.
- Disable distracting options (line numbers, active-line highlight) for a minimal source view.
- Pin CodeMirror and the CKEditor 5 bridge library through `composer.libraries.json` with the Composer Merge plugin.
- Troubleshoot "no highlighting" reports by checking that the `sourceEditing` toolbar item is present.
