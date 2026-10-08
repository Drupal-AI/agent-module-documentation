Block Description Modifier auto-fills and optionally hides the "Block description (info)" field of Custom Blocks, both as Layout Builder inline blocks and on regular block content forms.

---

The module targets `block_content.info` (the "Block description" / admin label of a Custom Block). On a central admin page (`/admin/config/content/block-description-modifier`) you list every Custom Block type (block_content bundle) and configure, per bundle, two independent modes: an **inline** mode that hides and enforces the label/title inputs in the Layout Builder add/edit block dialog, and a **content** mode that hides the info field on the normal block_content add/edit form and auto-fills it on save. Each mode picks one pluggable fill strategy — a fixed string (max 60 chars), the block type (bundle) label, or a copy of a chosen text field on the block — and every computed value is normalized (tags stripped, whitespace collapsed, trimmed to 60 chars). Missing or empty sources fall back to the literal string "corrupted field". Settings are stored as one config entity per bundle (`block_description_modifier.bundle.*`, entity type `bdm_bundle`); disabling both modes deletes the entity. It also hooks Inline Entity Form so content-mode rules apply to block_content edited inside nested subforms. All routes require the `administer block description modifier` permission.

---

- Give every Layout Builder inline block a consistent, predictable admin label without editors typing one.
- Hide the confusing "Block description (info)" field from editors on block content forms.
- Auto-name inline blocks from the block type label so layouts are easy to scan.
- Force a fixed string label (e.g. "Hero", "Promo card") on all blocks of a bundle.
- Derive a block's admin label from a real content field (e.g. a title or heading field) on the block.
- Keep inline block labels stable across a large, complex Layout Builder page.
- Stop editors from seeing or editing the info field while still keeping a meaningful stored value.
- Auto-fill info for referenced/nested Custom Blocks edited via Inline Entity Form widgets.
- Standardize block naming conventions across markets or multisite components.
- Reduce editorial overhead maintaining block descriptions by hand.
- Enforce a "Display title off" default for configured inline blocks in Layout Builder.
- Fall back to a safe placeholder ("corrupted field") when a source field is emptied or deleted.
- Configure inline and content behavior separately for the same block type.
- Limit label sources to genuine text fields (string, string_long, text, text_long, text_with_summary).
- Bulk-review which block types are configured as inline vs. available on one overview page.
- Delete per-bundle configuration via a confirm form when a block type no longer needs it.
- Migrate legacy `block_description_modifier.settings` config to per-bundle entities on update.
- Keep the info field populated on entity presave regardless of which form created the block.
- Avoid required-field validation errors when hiding info by injecting a valid enforced value.
- Present a clean Layout Builder dialog by hiding admin label, title, and display-title inputs for configured bundles.
