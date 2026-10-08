# Bricks Default Blocks — agent index

Demo/starter setup: Bricks + core custom blocks. Config-only submodule (no PHP). Parent: Bricks
([../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md)).

Installs (from `config/install/`):
- Node type `bricky_blocks` with Bricks field `field_body_blocks` (widget `bricks_inline`, formatter
  `bricks_nested`).
- `block_content` bundles: `image` (has `field_image`), `layout`, `wrapper`, with form/view displays.

Key facts:
- Depends on `bricks`, `bricks_inline`, `block_content`, `layout_discovery`, core field/file/image/node/
  text/menu_ui/path/user, and the `bartik` theme.
- Purpose: a working example to explore/copy; not production config.
- Sibling paragraphs-based demo: `bricks_default_paragraphs`.
