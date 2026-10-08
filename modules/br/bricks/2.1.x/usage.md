Bricks is a page-building field type built on top of core Entity Reference, display modes, the Layout API and tabledrag.js: it lets editors nest referenced entities into a drag-and-drop tree (like menu/taxonomy items), rendered recursively, as a lightweight alternative to Paragraphs/Panelizer.

---

The core module adds a `bricks` field type (`BricksTreeItem`, extending core `EntityReferenceItem`) that stores, per item, a `depth` (tinyint) and a serialized `options` blob in addition to the entity reference. Editors build a tree by dragging items and indenting them; `bricks_entity_presave()` runs `Bricks::correctDepths()` to normalise depths so each child is exactly one level below its parent. The `bricks_nested` formatter renders the referenced entities and `bricks_preprocess_field()` calls `Bricks::nestItems()` to fold the flat, delta-ordered render list into a nested tree (children under `bricks_children`), applying per-item `options`: a `view_mode` override, `css_class`/`css_id`, and — for items of a `layout` bundle when `layout_discovery` is enabled — a Layout API `layout` whose children are distributed into the layout's regions. Access-denied children are dropped. Bricks reuses ANY entity-reference-compatible widget: `hook_field_widget_info_alter()` adds the `bricks` field type to every such widget, and widget form alters inject the hidden `depth` field plus the inline `options` controls (view mode / layout / css class / css id). A legacy `bricks_tree_autocomplete` widget remains for back-compat. The module works with any entity type (ECK, nodes, custom blocks, paragraphs) and integrates with Entity Usage (a `bricks_field` tracker) and Replicate (when installed). No admin settings page (`configure` null); provides config schema mapping bricks field/widget/formatter settings onto their entity-reference equivalents. Seven submodules add default demo setups, revisioned/dynamic/paragraphs variants, and an Inline Entity Form widget.

---

- Build rich, nested page layouts from referenced entities without Paragraphs or Layout Builder.
- Nest bricks arbitrarily deep using drag-and-drop indentation (tabledrag).
- Reference any entity type (nodes, custom blocks, ECK entities, paragraphs) in one Bricks field.
- Override the view mode per referenced item (e.g. show one block as "featured").
- Add a custom CSS class and/or CSS id to an individual brick.
- Use a Layout API layout as a brick and drop child bricks into its regions.
- Replace a legacy Paragraphs setup with a lighter entity-reference-based tree.
- Reuse existing entity-reference widgets (autocomplete, IEF, etc.) for editing bricks.
- Edit bricks inline with Inline Entity Form via the `bricks_inline` submodule.
- Reference multiple different entity types in a single field via `bricks_dynamic`.
- Keep revisions of referenced bricks with `bricks_revisions` (entity_reference_revisions).
- Track where bricks reference entities using Entity Usage (`bricks_field` tracker).
- Clone bricky content correctly when the Replicate module is installed.
- Start from a ready-made demo (custom blocks) via `bricks_default_blocks`.
- Start from a ready-made demo (paragraphs) via `bricks_default_paragraphs`.
- Compose a landing page from reusable content blocks arranged in a tree.
- Build multi-column sections by nesting bricks inside a layout brick.
- Give editors a familiar menu-like drag UI instead of a nested-forms UI.
- Enforce consistent depth structure automatically on save (depth correction).
- Hide access-denied referenced entities (and their subtrees) from output.
- Support translations of the bricks tree (inline widget marks the field multilingual).
- Keep the stack in Drupal core (Entity Reference + Layout API) for lightweight maintenance.
