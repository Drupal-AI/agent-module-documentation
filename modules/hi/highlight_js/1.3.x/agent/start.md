<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Highlight Js syntax highlighter (highlight_js) — agent index

**CKEditor 5 code-block plugin + a text-format filter that renders the blocks with Highlight.js.**
Both halves — the editor side and the display side — ship in this one module. Depends on core
`ckeditor5`. Version **1.3.0**, core requirement `^9 || ^10 || ^11`, package "CKEditor 5".

## How it fits together
- **Editor side.** A CKEditor 5 plugin (`highlightJs`, `highlight_js.ckeditor5.yml`) adds a toolbar
  button. It opens a modal dialog (`HighlightJsDialogForm`, route `highlight_js.dialog` at
  `/highlight-js/dialog/{uuid}`, permission `use text format advanced`) where the author selects a
  language and pastes code. CKEditor stores a `<highlight-js data-plugin-id data-plugin-config>`
  element (the allowed element declared by the plugin). A preview endpoint
  (`/highlight-js/preview/{editor}`, access = `use text format <format>`) renders the block inside
  the dialog.
- **Display side.** The `@Filter` plugin `highlight_js` (`src/Plugin/Filter/HighlightJs.php`,
  `TYPE_TRANSFORM_REVERSIBLE`, weight 100) rewrites each `<highlight-js>` element into
  `<pre class="language-X"><code class="language-X" copy-enabled|copy-disabled>…</code></pre>`,
  and attaches `highlight_js/highlight_js.custom` + the selected theme library. See
  `agent/filters/highlight_js.md`.
- **Client side.** `js/highlight-custom.js` runs `hljs.highlightElement()` on every `<code>` element
  and, when enabled, wraps it and adds a Clipboard.js copy button.

## Assets come from a CDN
`highlight.min.js` 11.9.0 and `clipboard.min.js` 2.0.8, plus **every** theme stylesheet
(380+ entries in `highlight_js.libraries.yml`), are declared `type: external` pointing at
`cdnjs.cloudflare.com`, with **no** Subresource Integrity hash. There is no local-library or
`libraries_provider` option — the CDN dependency is unconditional whenever a code block is shown.

## Configuration & access
- Settings form `HighlightJsSettingsForm`, route `highlight_js.settings` at
  `/admin/config/content/highlight-js`, permission **`administer highlight_js configuration`**
  (declared `restrict access: TRUE`). See `agent/config/highlight_js.md`.
- Config object `highlight_js.settings` (schema in `config/schema/`). Chooses the available editor
  languages, the default theme (config default `github`; filter fallback if unset is `3024`), and
  the copy-button appearance / per-role access.

## Defines a plugin type
`@HighlightJs` annotation + `plugin.manager.ckeditor5_highlight_js` + `HighlightJsPluginBase`,
discovered under `Plugin/HighlightJs/`. Ships one plugin, `language_select` (`LanguageSelect`),
used only for the dialog preview.

## Gotchas
- The filter theme fallback (`?? '3024'`) differs from the settings-form/config default (`github`).
- `LanguageSelect::build()` attaches `highlight_js/highlight_js.tomorrow-night`, a library ID that
  does **not** exist in `highlight_js.libraries.yml` (the real one is `highlight_js.style-tomorrow-night`);
  affects only the in-dialog preview.
- The service ID has a backwards-compatible alias for a pre-MR11 typo
  (`plugin.manager.ckedito5_highlight_js`).
- Requires the text format to allow `<pre>`, `<code>`, and the `class` attribute.
