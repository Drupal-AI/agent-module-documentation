Block Component Library lets site builders flag reusable custom (content) blocks as "components" via a checkbox on every block type and browse or bulk-manage the flagged blocks from a dedicated view under Content.

---

The module ships no code beyond install/uninstall glue: it adds a single boolean field, `field_in_block_component_library` ("Add to Block Component Library"), to every `block_content` bundle and installs a Views listing, `block_component_library`, at `/admin/content/block-content-component-library` (a "Block Component Library" tab under the Content admin section). The view filters custom blocks to those that are reusable and have the flag set, shows description/type/status/language/updated columns, and exposes Views Bulk Operations (publish, unpublish, save, delete, bulk-edit, pathauto alias update) so editors can act on many components at once. Access to the listing is gated by the core `administer blocks` permission. On install the field is copied to all existing block bundles from the "basic" bundle's field config; on uninstall the field storage and the view are removed. There is no settings form, no custom route/controller, no service, no plugin, and no template — it is entirely a field + view configuration package on top of core Block content, Views, and the contributed Views Bulk Operations module.

---

- Mark a custom block as a reusable component by ticking "Add to Block Component Library" on the block's edit form.
- Give content administrators a single Content-area screen listing only the blocks curated as reusable components, separate from technical/system blocks.
- Browse all component blocks with sortable columns for block description, block type, status, language, and last-updated.
- Filter the component list by block description text, block type (bundle), status, and language via exposed filters.
- Bulk-publish a batch of selected component blocks with Views Bulk Operations.
- Bulk-unpublish component blocks to retire them from the library without deleting them.
- Bulk-delete obsolete component blocks from the listing.
- Bulk-save selected component blocks (e.g. to re-run save-time processing).
- Bulk-edit fields across many component blocks at once (via `views_bulk_edit`).
- Bulk-update URL aliases for component blocks when Pathauto is present (`pathauto_update_alias` action).
- Curate a design-system-style catalog of approved custom blocks that editors are meant to reuse across pages.
- Keep reusable marketing/CTA/hero blocks in one place for content teams to find and place.
- Distinguish editor-facing "component" blocks from developer-placed blocks in the block library.
- Onboard editors by pointing them at one library of vetted, reusable blocks.
- Add the checkbox automatically to custom block types created after install by re-copying the "basic" bundle's field configuration (run the install helper / reinstall for new bundles).
- Enforce a workflow where only blocks explicitly flagged appear in the shared component library.
- Audit which custom blocks are currently marked reusable and published.
- Provide a link to add a new custom block directly from the library screen (the "Add custom block" local action on the view page).
- Use the flagged field in your own views or code as a boolean marker of "is a library component".
- Restrict the library screen to trusted staff, since it is protected by the `administer blocks` permission.
- Cleanly remove the field and listing on uninstall without leaving orphaned configuration behind.
