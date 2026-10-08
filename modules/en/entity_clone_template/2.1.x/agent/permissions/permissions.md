# Permissions

From `entity_clone_template.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer entity_clone_template` | Enabling/disabling the feature per content type (the **Entity Clone Content** section on the node type form) and the **Entity Clone Template** flag/image controls on the node add/edit form. |

Notes:
- Core `administer nodes` is treated as an equivalent — both the node-type form section and the node-form
  template controls check `hasPermission('administer entity_clone_template') || hasPermission('administer nodes')`.
- Actually **cloning** content is gated by the underlying **Entity Clone** module's permissions
  (`clone <entity_type> entity`) and normal node create/edit access — this module only governs defining
  templates. Grant `administer entity_clone_template` to editors who should curate templates without full
  node administration.
