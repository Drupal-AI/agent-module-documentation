# Content Templates — agent index

Turn a node into a reusable `content_template` entity, then create new nodes pre-filled from it
via Quick Node Clone. No global config page (`configure` null). Depends on `node`, `media`,
`taxonomy`, and `quick_node_clone`.

- **The `content_template` entity, its fields, the four routes, node `template` base field, Views integration** →
  [configure/templates.md](configure/templates.md)
- **Permissions and what each gates (create template vs. create-from-template vs. overview)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Entity type `content_template` (single bundle `content_template`); main field `field_source`
  (entity_reference → node), plus `field_category` (taxonomy `template_category`) and `field_image`.
- Routes: `/node/{node}/template` (create/edit template from a node),
  `/node/template` (gallery of templates), `/template/{node}/quick_clone` (clone via quick_node_clone),
  `/node/{node}/overview` (list content created from a template).
- Node base field `template` records the source template a node was cloned from; exposed as a Views
  field/filter (`template_name`) added to the `content` admin view.
- Cloning keeps the original title (`hook_cloned_node_alter`); deleting a source node deletes its template.
