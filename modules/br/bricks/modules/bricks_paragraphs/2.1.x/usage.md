Bricks Paragraphs adds a `bricks_tree_paragraphs` widget built on the Paragraphs module's stable widget, so a Bricks field can be edited with the familiar Paragraphs editing experience while gaining the Bricks nested-tree structure.

---

The submodule provides one field widget, `bricks_tree_paragraphs` (`BricksTreeParagraphsWidget`), extending the Paragraphs module's `ParagraphsWidget` and applying to the `bricks` and `bricks_revisioned` field types (`multiple_values = false`). It gives editors the Paragraphs "add/collapse/drag" UI on top of a Bricks field, layering Bricks' depth/tree behaviour over the stable Paragraphs widget. Depends on `bricks` and `paragraphs`. No config UI, permissions, or Drush; rendering still uses the parent Bricks nested formatter and helper.

---

- Edit a Bricks field using the Paragraphs stable widget UI.
- Give editors the familiar Paragraphs add/collapse/drag experience on a Bricks tree.
- Combine Paragraphs editing ergonomics with Bricks' nested structure.
- Use with `bricks` or `bricks_revisioned` fields that reference paragraphs.
- Migrate a Paragraphs-heavy site to Bricks without changing the editor UX much.
- Build nested paragraph structures managed as a Bricks tree.
- Reuse existing Paragraphs types inside a Bricks field.
- Provide an alternative to the inline (IEF) and autocomplete Bricks widgets.
- Keep per-item Bricks options available while using the Paragraphs widget.
- Support paragraph-based components in a Bricks page builder.
- Offer editors the collapse/expand paragraph rows they already know.
- Nest paragraph components as a Bricks depth tree instead of flat rows.
- Use with `bricks_revisioned` fields for versioned paragraph trees.
- Provide a lower-friction migration path from Paragraphs to Bricks.
- Render the result with the standard Bricks nested formatter.
- Author landing pages from existing paragraph types via Bricks.
- Choose the Paragraphs widget when IEF or autocomplete UX is unsuitable.
- Preserve per-item view mode / layout / css options on paragraph bricks.
