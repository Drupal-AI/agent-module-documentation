# Content Templates — entity, routes, Views

No admin settings form. Everything is driven by the `content_template` entity + routes below.

## The `content_template` entity
- Content entity, id `content_template`, single bundle `content_template`.
- Access handler `ContentTemplateAccessControlHandler`: view/update/delete map to the matching
  `* content template entities` permissions (see permissions doc); create → `add content template entities`.
- Fields shipped in `config/install` / `config/optional`:
  - `field_source` — entity_reference to `node` (the node this template is built from). Required link.
  - `field_category` — entity_reference to taxonomy vocabulary `template_category` (created by the module).
  - `field_image` — image field for a gallery thumbnail.
  - plus the entity's own `name` label field.
- On install (`hook_modules_installed`) the module widens `field_source`'s allowed target bundles to
  include every existing node type.

## Routes (from `content_templates.routing.yml`)
| Route | Path | Access | Purpose |
|---|---|---|---|
| `content_templates.node.template` | `/node/{node}/template` | custom: `add content template entities` AND `clone {bundle} content` | Create or edit the template whose `field_source` = this node. Builds the `content_template` add/edit form. |
| `content_templates.node.overview` | `/node/{node}/overview` | custom: `access content from template overview` | Table of all nodes created from this node's template (title/author/created + edit/view). |
| `content_templates.node.add` | `/node/template` | `create content from template` | Gallery page listing published templates as rendered cards, grouped & weighted by `field_category`. Only templates whose source node the user can `clone` are shown. |
| `content_templates.node.quick_clone` | `/template/{node}/quick_clone` | `_entity_access: node.clone` | Delegates to `\Drupal\quick_node_clone\Controller\QuickNodeCloneNodeController::cloneNode` to clone the source node into a new draft. |

Action link "Create from template" is added to `system.admin_content` (the Content listing).

## Node `template` base field + Views
- `hook_entity_base_field_info` adds a non-configurable `template` entity_reference (→ node) base field
  to every node; `quickNodeCloneSubmit` sets it to the source node id when cloning through a template.
- `hook_views_data_alter` swaps the filter for `node_field_data.template` to the module's
  `template_name` Views filter (`src/Plugin/views/filter/TemplateName.php`, an `InOperator` with an
  entity-autocomplete value form).
- `content_templates_adjust_content_overview()` can add a "Content Template" exposed filter + field
  to the `content` view.
- `formNodeFormAlter` adds a "Created from" link to the node edit form's meta sidebar when a node has a
  `template` value.

## Notes for agents
- There is no `config/schema`; the module ships field/vocabulary config in `config/install` +
  `config/optional`, not a settings object.
- Cloning is done entirely by `quick_node_clone`; this module only wires routes, the template entity,
  and the source→clone mapping. `hook_cloned_node_alter` strips the "Clone of " title prefix for
  template clones.
