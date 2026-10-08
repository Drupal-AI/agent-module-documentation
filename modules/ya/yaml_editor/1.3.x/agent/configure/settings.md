<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Ace source and theme

The only settings are which Ace build to load and which Ace theme to use.

- **UI:** `/admin/config/development/yaml_editor` (route `yaml_editor.config`, menu link
  under *Configuration › Development*). Gated by permission **`configure yaml_editor`**.
- **Config object:** `yaml_editor.config` (schema type `config_object`).

## Keys

| Key | Default | Meaning |
|---|---|---|
| `editor_source` | `//cdnjs.cloudflare.com/ajax/libs/ace/1.2.0/ace.min.js` | URL (protocol-relative allowed) of the Ace `ace.min.js` to load. Point it at a self-hosted copy for offline sites. Injected as a `<script src>` at runtime *only if* a global `ace` isn't already present. |
| `editor_theme` | `ace/theme/chrome` | Ace theme id passed to `editor.setTheme()`, e.g. `ace/theme/monokai`. The matching theme file must be resolvable by the Ace build in `editor_source`. |

Note: install ships only `editor_source`; `editor_theme` is added by update hook
`yaml_editor_update_8001()` (default `ace/theme/chrome`), so a freshly installed site already
has both.

## Read / write with drush

```bash
# Read current values
drush cget yaml_editor.config editor_source
drush cget yaml_editor.config editor_theme

# Switch to a dark theme
drush cset -y yaml_editor.config editor_theme ace/theme/monokai

# Self-host / pin Ace
drush cset -y yaml_editor.config editor_source /libraries/ace/ace.min.js
```

Values take effect on the next admin page load (the JS reads them from
`drupalSettings.yamlEditor.source` / `.theme`). Both are attached in
`yaml_editor_page_attachments()` and only on **admin routes** — front-end textareas are never
enhanced regardless of the attribute.
