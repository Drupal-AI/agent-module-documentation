# Entity reference layout (ERL) — agent index

Paragraphs + Layout field. Field type `entity_reference_layout_revisioned`, widget
`entity_reference_layout_widget`, formatter `entity_reference_layout`. Depends on `paragraphs`,
`layout_discovery`, `jquery_ui_dialog`. **Experimental dev release (2.x)** — test heavily;
consider Layout Paragraphs for new sites. No Drush.

- **Field setup, the global settings form, and per-section layout options (classes/bg color)** →
  [configure/setup.md](configure/setup.md)
- **The one permission the module defines** → [permissions/permissions.md](permissions/permissions.md)
- **Events, the attribute-merge hook, and the field normalizer for code integration** →
  [api/events.md](api/events.md)

Submodules (own docs):
- `erl_layouts` (default column layouts) →
  [../../modules/erl_layouts/2.x/agent/start.md](../../modules/erl_layouts/2.x/agent/start.md)
- `erl_paragraphs` (default "Section" paragraph type) →
  [../../modules/erl_paragraphs/2.x/agent/start.md](../../modules/erl_paragraphs/2.x/agent/start.md)

Key facts:
- Field type adds properties `region`, `layout`, `section_id`, `options`, `config` to a
  paragraphs entity-reference-revisions item.
- Global config `entity_reference_layout.settings`: `show_paragraph_labels`,
  `show_layout_labels` (integers 0/1).
- Widget uses bundled `dragula` (loaded from CDN in `entity_reference_layout.libraries.yml`).
