<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Editor Enhancements (paragraphs_ee) — agent index

Restyles the Paragraphs "add" dialog: paragraph types become searchable, icon-rich **tiles**
grouped into custom **categories**. Active only when a Paragraphs field widget's
**Add mode = Modal form**. Depends on `paragraphs_features` (which requires `paragraphs`);
core `^11.4`. Hooks are OOP attribute classes under `src/Hook/` (`FieldHooks`, `FormHooks`,
`ThemeHooks`). No `configure` route in info.yml, but it adds a **Paragraphs categories** admin
at `/admin/structure/paragraphs_category`.

Provides:
- Config entity `paragraphs_category` (`src/Entity/ParagraphsCategory.php`) + admin routes.
- Route `paragraphs_ee.paragraphs_browser` (`/paragraphs_ee/browser/{entity_type}/{bundle}/{form_mode}/{field_name}`) → `ParagraphsOffCanvasBrowser` controller (off-canvas picker content).
- Widget third-party settings, theme hooks `paragraphs_add_dialog__categorized` + `input__submit__paragraph_action__image`, and `hook_paragraphs_ee_widget_access()`.
- Submodule `paragraphs_ee_sets` (documented separately under `modules/paragraphs_ee_sets/`).

Docs:
- Enable the dialog on a widget; category & display settings → [configure/paragraphs_ee.md](configure/paragraphs_ee.md)
- The off-canvas browser controller + category entity API → [api/paragraphs_ee.md](api/paragraphs_ee.md)
- Templates, theme hooks, libraries (tiles/list, Gin/Default-Admin accent, drag&drop) → [theming/paragraphs_ee.md](theming/paragraphs_ee.md)
- Permissions → [permissions/paragraphs_ee.md](permissions/paragraphs_ee.md)
- Allow/forbid the widget enhancements via a hook → [hooks/paragraphs_ee.md](hooks/paragraphs_ee.md)
