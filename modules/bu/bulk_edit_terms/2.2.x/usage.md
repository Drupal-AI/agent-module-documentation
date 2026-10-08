<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bulk Edit Terms adds a node action ("Update term references for the selected content") to the Content overview so editors can add, replace, clear or remove taxonomy-term (entity-reference) field values across many selected nodes at once.

---

The module registers a core Action plugin (`node_edit_terms_action`, type `node`) that appears in the *Action* dropdown on `admin/content`. Selecting nodes and applying it stashes the chosen node IDs in the per-user private tempstore and redirects to a confirmation form (`/admin/node/select/terms`, `NodeSelectTerms`) which lists every taxonomy-term entity-reference field found on at least one of the selected nodes. For each field the editor chooses an update mode — the `UpdateAction` enum defines `none`, `clear`, `replace`, `append`, `remove` — and the values to apply. On submit the module writes the changes only to nodes that actually have the field, and only where the current user passes both node `update` access and field `edit` access (checked in both the action's `access()` and the form's apply loop). Multi-value fields append on top of existing values by default; single-value fields are replaced. A small settings form (`/admin/config/content/bulk_edit_terms`, permission *administer bulk edit terms*) lets you choose the form widget used for multi-value term fields (`multi_value_widget_type`, default `entity_autocomplete`). The action itself is gated by core's `administer nodes` permission.

---

- Add a taxonomy term to hundreds of existing nodes in one operation.
- Replace an old category term with a new one across selected content.
- Clear a taxonomy-term field on a batch of nodes.
- Remove one specific term from many nodes without touching their other terms.
- Append tags to a set of nodes while keeping existing tags.
- Re-tag imported content that landed with the wrong taxonomy values.
- Reassign content from a deprecated vocabulary term to its replacement.
- Bulk-populate a newly added term reference field on legacy nodes.
- Normalize inconsistent tagging across a content type.
- Move nodes between topic categories during a site restructure.
- Apply an editorial "featured" or "section" term to a curated selection.
- Update term references on mixed content types in a single pass (only matching fields change).
- Choose an autocomplete vs other widget for entering multi-value term values.
- Restrict who can run bulk term edits via the `administer nodes` permission.
- Let a config-only role manage the module's widget setting via `administer bulk edit terms`.
- Clean up tag sprawl by removing a redundant term site-wide.
- Seasonally swap a "current campaign" term across promoted nodes.
- Respect per-node and per-field access so editors only change what they may edit.
- Prepare content for a taxonomy merge by appending the target term first.
- Bulk-assign workflow/section terms after a content migration.
