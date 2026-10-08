<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prevent entity unpublish stops content editors from unpublishing a node, taxonomy term or user account while another entity still references it, extending the entity_reference_integrity model from deletes to publish state.
---
Its machine name is `prevent_entity_unpublish` (project `prevent_entity_unpublished`). A settings form at `/admin/config/content/prevent-entity-unpublish` lets an administrator choose which of the supported entity types (node, taxonomy_term, user) the protection applies to; the selection is stored in `prevent_entity_unpublish.settings:enabled_entity_type_ids`. A `hook_form_alter` adds a validate handler to node/taxonomy-term/user edit forms. When the submitted status is unpublished (0), the handler asks the entity_reference_integrity dependency manager whether the entity has dependents; if it does and the type is enabled, a form validation error is set listing the referencing entities, so the save is blocked.

The settings route is gated by the `administer prevent entity unpublish` permission (marked `restrict access: true`). The module has no anonymous or mutating endpoints of its own — it only alters existing entity edit forms and reads/writes its own config. It requires the entity_reference_integrity and entity_reference_integrity_enforce contrib modules. Setup is: install those dependencies, enable this module, then tick the entity types to protect on the settings form.
---
- Prevent unpublishing a node that other content still references
- Prevent unpublishing a taxonomy term that is referenced elsewhere
- Prevent unpublishing a user account referenced by other entities
- Choose exactly which entity types the protection covers
- Enforce referential integrity on publish state, not just on delete
- Show editors the list of entities blocking an unpublish
- Protect landing-page building blocks from being hidden accidentally
- Keep referenced media/authors visible while in use
- Limit protection to nodes only by unticking other types
- Reach the config screen from its admin menu link
- Store the protected-type selection in exportable config
- Combine with entity_reference_integrity's delete protection
- Give a clear validation message instead of a silent broken reference
- Audit which content depends on a term before unpublishing it
- Turn protection on or off per environment via config
- Restrict access to the settings form with a dedicated permission
- Prevent broken references on curated reference fields
- Keep required author accounts published
- Ensure referenced services/pages stay live
- Roll the setting out gradually, one entity type at a time
