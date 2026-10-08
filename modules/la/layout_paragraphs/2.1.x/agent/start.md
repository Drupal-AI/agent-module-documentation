# layout_paragraphs — agent start

Drag-and-drop layout builder for a Paragraphs reference field. Provides a `layout_paragraphs`
field **widget**, two field **formatters** (`layout_paragraphs`, `layout_paragraphs_builder`),
and a `layout_paragraphs` Paragraphs **Behavior** plugin that turns a paragraph type into a
layout **section** using core Layout Discovery layouts. Depends on `paragraphs` and
`layout_discovery`. Module settings route: `layout_paragraphs.label_settings`
(**Admin → Config → Content authoring → Layout Paragraphs**, `/admin/config/content/layout_paragraphs/labels`).

- Set up the widget/formatter, section behavior & builder settings → [configure/layout_paragraphs.md](configure/layout_paragraphs.md)
- Restrict components/layouts & alter defaults via events → [api/layout_paragraphs.md](api/layout_paragraphs.md)
- Templates, theme hooks & builder preprocessing → [theming/layout_paragraphs.md](theming/layout_paragraphs.md)
- Submodule: reuse components via Paragraphs Library → [../../modules/layout_paragraphs_library/2.1.x/agent/start.md](../../modules/layout_paragraphs_library/2.1.x/agent/start.md)
- Submodule: granular reorder/duplicate permissions → [../../modules/layout_paragraphs_permissions/2.1.x/agent/start.md](../../modules/layout_paragraphs_permissions/2.1.x/agent/start.md)
