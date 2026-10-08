Adds Enable / Disable / Delete bulk actions to Drupal's core Block layout page so an administrator can operate on many block instances at once.

---

Blocks Bulk Actions alters the core Block layout admin form (`block_admin_display_form`, at `/admin/structure/block`) via `hook_form_alter()`, adding a checkbox to each block row, a select/deselect-all toggle, an action dropdown and an "Apply to selected items" button. The dropdown is populated from a custom `BlocksBulkActions` plugin type, and the three shipped plugins (Enable, Disable, Delete) each act on selected `block` config entities through the Batch API. It requires no other contrib modules, defines no routes/permissions/config of its own, and reuses the core page's `administer blocks` access control. Developers extend it by adding a plugin annotated `@BlocksBulkActions` implementing `execute()` (and optionally `access()`).

---

- Disable a large group of blocks in one theme at once without opening each block's edit form.
- Re-enable multiple previously disabled blocks together after a maintenance window.
- Delete many stale or leftover block instances from a theme's regions in a single operation.
- Clean up blocks after importing or migrating a theme that created dozens of block instances.
- Bulk-remove demo/placeholder blocks shipped by a starter theme or distribution.
- Speed up block housekeeping on sites with many custom blocks placed across regions.
- Select all blocks on the layout page with one checkbox, then apply a single action.
- Toggle a curated subset of blocks off before a seasonal campaign, then back on afterward.
- Apply the same enable/disable change consistently across blocks that must move together.
- Reduce clicks for site builders who routinely reorganize block placement.
- Remove orphaned blocks left behind when a module that provided them was uninstalled.
- Provide editors a faster path to hide multiple promotional blocks at once.
- Prepare a theme for launch by disabling all non-final blocks in bulk.
- Batch-process block changes so large operations run in chunks instead of one long request.
- Add project-specific block operations (e.g. clear a block's visibility, reset settings) by writing a custom `@BlocksBulkActions` plugin.
- Restrict which bulk actions appear to a given user by overriding a plugin's `access()` method.
- Limit an action to specific block IDs by setting the plugin annotation's `bids` property.
- Standardize block cleanup steps across multiple sites that share the same custom module.
- Give administrators a sticky, always-visible actions bar while scrolling a long block list.
- Audit and prune blocks region-by-region during a site content review.
