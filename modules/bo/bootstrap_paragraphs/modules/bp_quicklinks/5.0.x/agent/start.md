<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Paragraphs Quicklinks — agent index

Config-only submodule of **bootstrap_paragraphs**. Installs exactly one paragraph type,
`bp_quicklinks` ("Quicklinks"), that renders an unlimited `link` field as a flex grid of
tiles. No configure route, no settings form, no permissions, no Drush, no plugins, no
services. PHP is only `hook_theme()` + `hook_help()`.

- **The bundle, its four fields, the widget/formatter settings, and how to expose it on a
  content type** → [configure/quicklinks-bundle.md](configure/quicklinks-bundle.md)
- **Template, libraries and the CSS classes it emits** →
  [theming/template.md](theming/template.md)

Key facts:

| | |
|---|---|
| Paragraph type | `bp_quicklinks` (label `Quicklinks`) |
| Own field | `bp_quick_link` — `link`, **cardinality `-1`**, `link_type: 17`, `title: 1` |
| Inherited fields | `bp_header` (string), `bp_width`, `bp_background` (`list_string`) |
| Form widget | `link_attributes` (contrib **link_attributes**); only `target` + `rel` enabled |
| View formatter | `link` |
| Config location | `config/optional/` — imported on install, **not** removed on uninstall |
| Extra dependency | `drupal/link_attributes` (on top of `paragraphs` + `bootstrap_paragraphs`) |

Nothing is editor-visible until an `entity_reference_revisions` (Paragraphs) field on some
bundle lists `bp_quicklinks` in `settings.handler_settings.target_bundles`.
