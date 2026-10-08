# Configuration

Entity Inherit needs one piece of setup: telling it **which field(s) define an
entity's parent**. Everything else happens automatically when entities are saved.

## Set up the parent field

1. **Create a parent field.** On the bundles that should inherit, add a field that
   marks an entity's parent — typically an **entity‑reference** field, for example
   named `field_entity_inherit_parent`. This field holds the reference from a child
   to its parent entity.
2. **Register it with Entity Inherit.** Go to `/admin/config/entity_inherit` (the
   settings form, gated by the **Access administration pages** permission) and enter
   that field's machine name as a parent field. The setting is stored in the
   module's configuration.
3. **Match field names.** For any field to actually inherit, the parent and the
   child must use the **same field name**. Only fields that exist on both, by the
   same name, participate.

## How propagation behaves

Once a parent field is registered, the module acts on **every entity save**:

- **A parent's field changes.** If a parent field's value changes and a child
  previously held the parent's *old* value, the child is updated to the new value.
- **A new parent link is added.** If an entity gains a parent reference, its *empty*
  fields that also exist on the parent are filled in from the parent.
- **Large sets are queued.** When many entities are affected, propagation runs
  through the module's queue (a batch or non‑batch processor) rather than all at
  once.
- **No data lock‑in.** Values are recomputed and stored on save, so you can disable
  or uninstall the module later without losing the inherited data.

## Cautions to plan around

- **No cross‑save loop protection.** The module only guards a single save against
  loops. Avoid circular parent graphs (A → B → A), which will produce errors.

## Extending it (developers)

Inheritance behavior can be extended with the module's plugin system by
implementing an `EntityInheritPlugin`. The module bundles example plugins (handling
legacy field formats, queue processing, and removing system fields) to learn from —
see the sibling [`agent/`](../agent/start.md) docs for specifics.
