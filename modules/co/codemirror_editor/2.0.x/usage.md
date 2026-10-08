The CodeMirror Editor integrates the CodeMirror code editor library into Drupal, giving syntax-highlighted, line-numbered code editing and display in text-format editors, fields, a filter, and a reusable form element.

---

The module wires CodeMirror into Drupal through several plugins that all share one JS library and toolbar. It provides: a text-format **Editor** plugin (`codemirror_editor`) you enable on a text format so its textarea becomes a CodeMirror instance; a **Filter** plugin (`codemirror_editor`, transform-irreversible) that renders code inside content with CodeMirror; a **Field widget** and **Field formatter** (both `codemirror_editor`, for `string_long` / `text_long` fields); and a `#type => 'codemirror'` **render element** (extending `textarea`) for custom forms. Global behavior is set on a settings form at `/admin/config/content/codemirror` (route `codemirror_editor.settings`, permission `administer codemirror editor`), stored in `codemirror_editor.settings`: whether to load the library from a **CDN** (`cdn`), use the **minified** build (`minified`), the editor **theme**, and which **language modes** to preload (`language_modes`). Language modes are a plugin type of their own: a YAML plugin manager (`plugin.manager.codemirror_mode`) discovers modes from any module's `MODULE.codemirror_modes.yml`; 12 modes ship by default (clike, css, htmlmixed, javascript, markdown, php, python, ruby, sql, twig, xml, yaml). When the CDN option is off, the CodeMirror JS/CSS must be present under `libraries/codemirror`; the Drush command `codemirror:download` fetches it, and a runtime requirement check warns if it is missing. Two alter hooks (`hook_codemirror_mode_info_alter`, `hook_codemirror_editor_assets_alter`) let modules add modes or extra assets.

---

- Turn a text format's editor into a syntax-highlighting CodeMirror editor.
- Give site builders a code field (widget) for HTML/CSS/JS/PHP snippets on content types.
- Display stored code with line numbers and highlighting via the CodeMirror field formatter.
- Highlight code blocks inside rendered content using the CodeMirror filter.
- Add a `#type => 'codemirror'` textarea to a custom form for code input.
- Preload only the language modes you need (e.g. css, javascript, twig) to keep pages light.
- Serve the CodeMirror library from a CDN to avoid bundling library files.
- Switch to a locally downloaded, minified CodeMirror build for offline/self-hosted sites.
- Download the CodeMirror library with `drush codemirror:download` instead of manual placement.
- Pick an editor theme (e.g. default, material) for all CodeMirror instances.
- Provide an HTML editing experience with tag auto-closing and a formatting toolbar.
- Edit Twig template snippets with Twig-aware highlighting in an admin form.
- Offer a Markdown editing field with Markdown mode highlighting.
- Let developers paste SQL and get SQL keyword highlighting.
- Add a custom CodeMirror language mode by shipping a `MODULE.codemirror_modes.yml` file.
- Force a specific language mode to always load via `hook_codemirror_mode_info_alter()`.
- Add CodeMirror addons (e.g. a dialog) via `hook_codemirror_editor_assets_alter()`.
- Configure per-widget rows, placeholder text, and language mode on a code field.
- Enable line wrapping, line numbers, and code folding per formatter/filter.
- Restrict who can change the global CodeMirror configuration with a dedicated permission.
- Present read-only, highlighted code output in a view or entity display.
- Standardize a code-entry UX across multiple content types and forms.
- Build an in-browser snippet manager where entries are edited and shown with CodeMirror.
- Toggle a toolbar with bold/italic/list/link buttons for rich HTML editing.
