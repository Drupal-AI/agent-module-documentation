<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ace Editor integrates the JavaScript [Ace](https://ace.c9.io/) code editor into Drupal, turning plain textareas into a code editor with syntax highlighting, line numbers, and themes. It plugs in three ways: as a text-format editor plugin, as a field formatter, and as a text filter.

---

The module wraps the external Ace ("ace-builds") library and exposes it through core's existing extension points rather than defining any of its own plugin types. `Drupal\ace_editor\Plugin\Editor\AceEditor` registers an `ace_editor` **text-editor plugin** (via core's `editor` module) so you can assign the Ace code editor to any text format on *Text formats and editors*; its per-format settings (theme, syntax/mode, height, width, font size, line numbers, print margin, invisibles, word wrap, autocomplete) are saved under `settings.fieldset.*` of an `editor.editor.<format>` config entity. `Drupal\ace_editor\Plugin\Field\FieldFormatter\AceFormatter` adds an `ace_formatter` **field formatter** for `text_long` and `text_with_summary` fields that renders stored text in a read-only Ace view. `Drupal\ace_editor\Plugin\Filter\AceFilter` adds an `ace_filter` **text filter** that converts `<ace>…</ace>` tags (with optional per-tag attributes like `theme` and `syntax`) in body text into highlighted code snippets. A single global config object, `ace_editor.settings`, holds the module-wide default values plus the full `theme_list` / `syntax_list` option maps — there is **no admin settings form and no configure route**, so you edit those defaults with `drush config:set` or config import. The Ace JavaScript library is not bundled: you must download it from [ajaxorg/ace-builds](https://github.com/ajaxorg/ace-builds) into `/libraries/ace` (or `/libraries/ace-builds`), and `hook_requirements()` reports an error until it is present. Note the shipped `ace_editor.permission.yml` file is mis-named (core only discovers `*.permissions.yml`), so the intended `administer ace_editor` permission is **not** actually registered.

---

- Turn a text format's textarea into a full code editor for editing raw HTML, PHP, JS, or CSS.
- Give developers syntax highlighting and line numbers when editing a "custom code" long-text field.
- Assign the Ace editor to a dedicated "Snippet" or "Raw HTML" text format used by a code block type.
- Display the contents of a `text_long` field as read-only, syntax-highlighted code with the `ace_formatter`.
- Show a stored configuration/log field with proper indentation and a monospaced code theme.
- Embed inline code samples in body copy with `<ace syntax="php">…</ace>` via the `ace_filter`.
- Override the highlighting language per snippet using the `syntax` attribute on an `<ace>` tag.
- Override the color theme per snippet using the `theme` attribute on an `<ace>` tag.
- Present JSON, YAML, or SQL examples in documentation nodes with language-appropriate highlighting.
- Set a site-wide default editor theme (e.g. `monokai`, `twilight`) in `ace_editor.settings`.
- Standardize the default editor height/width and font size for all Ace instances via global config.
- Toggle line numbers, the 80-char print margin, invisible characters, or word wrap per text format.
- Enable Ctrl+Space autocomplete in the editor by keeping `auto_complete` on.
- Provide a comfortable editing surface for a "CSS injection" or "custom JS" administrative field.
- Let editors write and preview HTML email templates with highlighting before saving.
- Configure different languages per format (e.g. a "PHP snippets" format vs a "Markdown" format).
- Deploy editor configuration as code by exporting the `editor.editor.<format>` config entity.
- Roll a consistent code-editing experience across node, block, and custom-entity edit forms.
- Replace core's plain textarea for technical content without writing a custom widget.
- Offer a read-only, highlighted rendering of user-submitted code on a display view mode.
- Present API examples on a docs site with per-tag language selection using the filter.
- Choose from Ace's full theme catalogue (Cobalt, Monokai, Twilight, Solarized, Xcode, …) per format.
- Switch highlighting to any of Ace's ~130 supported modes (Python, Rust, Twig, YAML, …).
- Keep editor defaults in version control and change them per-environment via `drush config:set`.
