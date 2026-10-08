# paragraphs_ee — agent start

Paragraphs Editor Enhancements restyles the Paragraphs "add" dialog: paragraph types become
searchable, icon-rich **tiles** grouped into custom **categories**. Active only when a
Paragraphs field widget's **Add mode = Modal form**. Depends on `paragraphs_features` (which
requires `paragraphs`); core `^11.3`. No `configure` route declared in info.yml, but it adds a
**Paragraphs categories** admin at `/admin/structure/paragraphs_category`.

- Enable the dialog on a widget; category & display settings → [configure/paragraphs_ee.md](configure/paragraphs_ee.md)
- Templates, theme hooks, libraries (tiles/list, Gin accent, drag&drop) → [theming/paragraphs_ee.md](theming/paragraphs_ee.md)
- Permissions → [permissions/paragraphs_ee.md](permissions/paragraphs_ee.md)
- Allow/forbid the widget enhancements via a hook → [hooks/paragraphs_ee.md](hooks/paragraphs_ee.md)
