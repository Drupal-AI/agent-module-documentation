<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Inherit lets entities inherit certain field values from a "parent" entity (referenced through configured parent fields), re-evaluating and propagating those values every time an entity is saved.
---
You configure, at `/admin/config/entity_inherit`, which field(s) define an entity's parent (typically an entity_reference field such as `field_entity_inherit_parent`). On `hook_entity_presave()` the module's `EntityInherit` service compares the saved entity against its parents and children: when a parent field changes and a child previously held the same value, the child's field is updated to the new parent value; and when an entity gains a new parent reference, its empty fields are filled from the parent. Propagation across many affected entities is done through a queue with a batch/no-batch processor, and an anti-infinite-loop utility guards a single save (site builders are still warned to avoid circular parent graphs). The behaviour is extensible via an `EntityInheritPlugin` plugin type (bundled plugins handle legacy field formats, queue processing, and removing system fields). Because values are recomputed on save, the module can be disabled at any time without data loss.

**Propagation:** happens in the presave path (`entity_inherit_entity_presave()` → `EntityInherit::hookPresave()`), which loads and saves the related entities directly (see the README's "Note about permissions"). Plan which fields are used as parent fields and who can edit parent entities. The admin settings route is gated by `access administration pages`.
---
- Make several entities share a field value sourced from one parent entity.
- Define which field(s) mark an entity's parent at /admin/config/entity_inherit.
- Propagate a parent's updated field value to all matching child entities on save.
- Fill a child's empty fields from a parent when a parent reference is added.
- Change many nodes' values without altering the data model.
- Keep a common "policy" field consistent across many entities.
- Use an entity_reference field as the parent pointer.
- Process large propagation sets via the built-in queue and batch processor.
- Disable the module later without losing data (values are stored on save).
- Extend inheritance behaviour with a custom EntityInheritPlugin.
- Handle legacy field formats via the bundled plugin.
- Strip system fields from inheritance via the RemoveSystemFields plugin.
- Trigger queued reprocessing via the ProcessQueue plugin.
- Inherit fields only when child and parent share the same field name.
- Guard a single save against infinite loops with the anti-loop utility.
- Audit which fields are configured as parent fields via the admin form.
- Restrict parent-entity edit rights to control who can trigger propagation.
- Model shared attributes (e.g. shared policy text) across content.