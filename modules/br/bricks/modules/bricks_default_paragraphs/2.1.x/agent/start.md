# Bricks Default Paragraphs — agent index

Demo/starter setup: Bricks + Paragraphs. Config-only submodule (no PHP). Parent: Bricks
([../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md)).

Installs (from `config/install/`):
- Node type `bricky_paragraphs` with Bricks field `field_body_paragraphs`.
- Paragraph types `layout` and `wrapper`, with form/view displays wiring them into the Bricks tree
  (nested formatter `bricks_nested`).

Key facts:
- Depends on `bricks`, `bricks_inline`, `bricks_revisions`, `paragraphs`, `paragraphs_demo`, and core
  field/language/menu_ui/node/path/user.
- Purpose: a working example to explore/copy; not production config.
- Sibling blocks-based demo: `bricks_default_blocks`.
