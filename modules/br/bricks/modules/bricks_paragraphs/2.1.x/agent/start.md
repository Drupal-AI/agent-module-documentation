# Bricks Paragraphs — agent index

Adds the `bricks_tree_paragraphs` widget (Bricks field edited with the Paragraphs stable widget).
Parent: Bricks ([../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md)). Depends on `bricks`,
`paragraphs`.

Plugin:
- Widget `bricks_tree_paragraphs` (`BricksTreeParagraphsWidget` extends Paragraphs' `ParagraphsWidget`),
  field types `bricks` + `bricks_revisioned`, `multiple_values = false`.

Key facts:
- Layers Bricks' depth/tree behaviour onto the stable Paragraphs editing UI.
- Rendering unchanged — uses the parent Bricks nested formatter/helper
  ([../../../../2.1.x/agent/api/rendering.md](../../../../2.1.x/agent/api/rendering.md)).
- No config UI, permissions, or Drush.
