Block Region Permissions adds a granular permission per theme region so you can let a role administer blocks in only certain regions of the Block layout page, instead of granting the all-or-nothing core "Administer blocks" permission.

---

Drupal core gates the entire Block layout UI behind one permission, "Administer blocks", which lets a user place, move, configure, and delete blocks in every region of every theme. This module dynamically generates one permission per enabled (non-hidden) theme region — machine name `administer {theme} {region}`, titled "Administer: {Theme} - {Region}" — by reading each theme's `regions` from its info file. It then alters the Block layout form (`block_admin_display_form`) and the block add/configure form (`block_form`) to hide the blocks and region-select options for regions the current user lacks permission for, implements `hook_block_access()` to forbid update/delete on blocks in off-limits regions, and registers a route subscriber that adds a `_custom_access` check to the block edit and delete form routes so the restriction is enforced at the access layer, not just visually. Because core still requires "Administer blocks" to reach the page at all, that permission remains a prerequisite and, on its own, still exposes block pages this module does not manage (e.g. delete/disable/library routes) — the project recommends pairing with Block Content Permissions to lock down the rest. The module has no configuration form, no settings, no config schema, no Drush commands, and no dependencies beyond core's Block module.

---

- Let a "site builder" role manage blocks only in the Content and Sidebar regions while leaving Header, Footer, and admin regions off-limits.
- Give a marketing team permission to arrange blocks in a promotional region without exposing the rest of the theme's layout.
- Delegate block placement per-theme so an editor can only touch the front-end theme's regions, never the admin theme's.
- Prevent a role from moving a block into a region they are not allowed to administer by removing that region from the block's region select field.
- Hide block rows on the Block layout page for regions a user cannot administer, decluttering the UI.
- Enforce region restrictions server-side on the block edit form so a crafted URL to `entity.block.edit_form` is denied.
- Enforce region restrictions server-side on the block delete form (`entity.block.delete_form`) via the added `_custom_access` requirement.
- Forbid update and delete operations on individual blocks in restricted regions through `hook_block_access()`, which also hides their contextual operation links.
- Grant per-theme, per-region control across a multi-theme site where each theme has different regions.
- Scope block administration for a subsite or brand region to a dedicated role without a custom access module.
- Combine with Block Content Permissions to also restrict the Custom block library pages the core permission would otherwise expose.
- Build a least-privilege block-editing role that has "Administer blocks" plus only the specific region permissions it needs.
- Restrict contractors or agency users to editing blocks in a single region during a temporary engagement.
- Keep critical regions (e.g. Header, Primary menu) editable only by administrators while opening low-risk regions to content teams.
- Audit which roles can edit which regions by reviewing the discrete `administer {theme} {region}` permissions on the People > Permissions page.
- Automatically expose new region permissions when a theme adds a region or a new theme is enabled, since permissions are generated dynamically from theme info.
- Give a role the ability to place blocks (region options filtered to allowed regions) on the Place block configure form.
- Reduce the blast radius of the core "Administer blocks" permission on sites with many contributors.
- Support editorial workflows where different teams own different areas of the page.
- Assign region ownership in a design system where header/footer are locked and body regions are delegated.
- Provide granular block access without writing a custom module or access-check service.
- Limit which regions appear in the region dropdown when reconfiguring an existing block.
- Let a role administer a theme's "disabled" region handling implicitly while its enabled placements are still gated per region.
- Use as a lightweight, dependency-free permissions layer on Drupal 8, 9, 10, or 11 sites.
- Model per-region governance for compliance or brand-consistency requirements.
- Onboard a new team by granting only the region permissions matching their responsibilities.
