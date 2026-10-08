# Geysir — agent index

Front-end (in-place) management of Paragraphs on nodes via AJAX modals: add, edit, delete,
cut/paste, translate. Depends on `paragraphs` + `entity`. No config UI (`configure` null),
no config schema, no Drush. One permission; one alter hook.

- **The single permission and exactly what it gates** →
  [permissions/geysir.md](permissions/geysir.md)
- **`hook_geysir_paragraph_links_alter()` — add/modify per-paragraph action links** →
  [hooks/geysir.md](hooks/geysir.md)

Key facts:
- Works only on `entity_reference_revisions` fields targeting `paragraph`, and only when the
  parent is a **node** (nested-paragraph parents are skipped). Buttons render only if the
  user has the permission AND `$node->access('update')` AND it's the latest, default-language
  revision (translate mode on non-default translations).
- Buttons are injected by `geysir_preprocess_field()` / `geysir_preprocess_node()`; each is a
  `use-ajax` link to a `/geysir/...` route that opens a Drupal modal.
- Modal forms are custom paragraph entity forms registered in `geysir_entity_type_build()`:
  `geysir_modal_edit`, `geysir_modal_delete`, `geysir_modal_add` (plus non-modal
  `geysir_edit`/`geysir_delete`). Saving re-saves a NEW revision of the parent entity and
  AJAX-replaces the field wrapper.
- Routes (`geysir.routing.yml`) all require only `_permission: 'geysir manage paragraphs from
  front-end'`; the context (parent type/bundle/revision, field, delta, paragraph id/revision,
  position, bundle) is passed as path params.
- A toolbar tab (`geysir/geysir-toolbar`) shows/hides the buttons client-side.
