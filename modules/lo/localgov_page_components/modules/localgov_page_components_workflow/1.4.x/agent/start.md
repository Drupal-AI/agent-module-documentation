# LocalGov Page Component Workflow — agent index

Content-moderation cascade + "smart revisions" formatter for the `localgov_page_components`
field. No settings page, no permissions, no Drush. Depends on `content_moderation`,
`paragraphs_library`, `localgov_page_components`.

- **The bundled workflow, the smart-revisions formatter, the node_update cascade, and setup steps**
  → [configure/workflow.md](configure/workflow.md)

Key facts:
- Workflow `page_components` (Draft/Published) applied to `paragraphs_library_item`; installed by
  `config/install/workflows.workflow.page_components.yml`.
- Formatter `localgov_page_components_workflow_formatter` ("Page components (smart revisions)")
  for `entity_reference` fields — set it on *Manage display* for the Page components field.
- `src/Hook/NodeHooks.php` `#[Hook('node_update')]` cascades node moderation state to referenced
  components (new revision + status + recursive paragraph revision re-pointing).
- Caveat: saving a component *directly* as Published publishes it immediately regardless of node state.
