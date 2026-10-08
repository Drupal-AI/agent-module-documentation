<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mercury Editor — agent index

A drag-and-drop, live-preview page builder that **replaces the standard edit form** for chosen
bundles with an edit screen at `/mercury-editor/{entity}`. Built on `layout_paragraphs` +
`style_options`. Single config object `mercury_editor.settings`; **no permissions of its own**
(gated by core "administer site configuration" + Layout Paragraphs access), **no Drush**, **no
plugin types**.

- **Enable it for a bundle, all `mercury_editor.settings` keys, the four settings routes** →
  [configure/settings.md](configure/settings.md)
- **Architecture: how the form is replaced, key services, routes, tempstore, dialog system** →
  [api/architecture.md](api/architecture.md)

Submodules (nested docs under `modules/`):
- **mercury_editor_templates** — reusable section templates (`me_template` entity, own permissions).
- **mercury_editor_inline_editor** — DEPRECATED empty shim; use `mercury_editor_live_edit` instead.

Key facts: config `mercury_editor.settings`; enable a bundle via `bundles.<entity_type>.<bundle>`
(e.g. `bundles.node.landing_page: landing_page`); settings UI at
`/admin/config/content/mercury-editor` (route `mercury_editor.settings`). Requires the bundle to
use Layout Paragraphs.
