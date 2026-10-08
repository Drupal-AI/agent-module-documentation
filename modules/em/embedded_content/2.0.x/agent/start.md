<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Embedded Content — agent index

Framework for **reusable, configurable components** editors insert into CKEditor 5 without HTML
rights. Two moving parts: an `embedded_content` **plugin type** (the components) and
`embedded_content_button` **config entities** (the editor buttons), tied together by the
`embedded_content` text filter + a derived CKEditor 5 toolbar item. Requires `ckeditor5`.
No global settings page (`configure: null`); admin UI is per button.

- **Write an Embedded Content plugin (annotation, base class, `build()`, `isInline()`, config form)** →
  [plugins/embedded-content.md](plugins/embedded-content.md)
- **Create/configure a button (`embedded_content.button.*` settings) and wire the filter + toolbar into
  a text format** → [configure/buttons.md](configure/buttons.md)
- **The `embedded_content` filter and the `<embedded-content>` tag round trip** →
  [api/filter.md](api/filter.md)
- **Permissions (`administer embedded content` + dynamic per-button)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Plugin type id `embedded_content`; plugins live in `Plugin/EmbeddedContent/`, annotation
  `@EmbeddedContent(id, label)`, extend `EmbeddedContentPluginBase`, implement `build()` + `isInline()`.
- Button config entity: `embedded_content.button.<id>` (config_prefix `button`); keys `id`, `label`,
  `settings` (icon, label_singular, submit_button_text, modal_title, conditions, dialog_settings).
- **Ships zero concrete plugins by default** — you provide them in code (see `embedded_content_test`).
- Plugin manager service: `plugin.manager.embedded_content`.
