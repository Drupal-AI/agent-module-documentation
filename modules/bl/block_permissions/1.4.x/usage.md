<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block Permissions splits core's all-or-nothing "administer blocks" into fine-grained permissions — one per enabled theme and one per block-plugin provider — so a client can manage front-end blocks without touching the admin theme or system blocks.

---

The module generates its permissions dynamically through a `permission_callbacks` entry pointing at `Drupal\block_permissions\BlockPermissionsPermissions::permissions()`. That method emits `administer block settings for theme <theme_machine_name>` for every installed, non-hidden theme, and `administer blocks provided by <provider>` for every distinct `provider` found in the block plugin definitions — so the permission list grows and shrinks as themes and modules are enabled. A route subscriber (`block_permissions.route_subscriber`) then bolts a `_custom_access` requirement onto six core block routes — `block.admin_display`, `block.admin_display_theme`, `block.admin_add`, `entity.block.edit_form`, `entity.block.delete_form` and `block.admin_library` — resolved by `BlockPermissionsAccessControlHandler`, which checks the theme permission for list routes, the provider permission for edit/delete, and *both* for the add form. The block library route additionally gets a subclassed controller that filters out every row whose "Add block" link the user cannot access, so the palette only shows placeable blocks. Finally `hook_form_block_admin_display_form_alter()` walks the Block layout drag-and-drop table and, for each block whose provider the user lacks permission for, hides the weight element, removes the region select and the operations links, and swaps the `draggable` class for `undraggable` — the row stays visible but is frozen. These permissions **refine** rather than replace core's `administer blocks`: a user still needs the core permission, plus the theme permission for the default theme to reach `/admin/structure/block` at all.

---

- Let a client manage blocks on the public theme while the admin theme stays untouched.
- Give a marketing role permission to place only `block_content` (custom) blocks.
- Prevent editors from placing System blocks such as "Powered by Drupal" or the main menu.
- Allow a role to manage Views blocks but nothing else, by granting only `administer blocks provided by views`.
- Restrict the Block layout page for one theme in a multi-theme site.
- Hide unusable rows from the "Place block" library so editors are not shown blocks they cannot add.
- Freeze specific rows on the Block layout drag-and-drop table for unprivileged roles.
- Delegate footer/sidebar block management to a site-editor role without full site-building rights.
- Stop an agency client from breaking the admin UI by moving admin-theme blocks.
- Grant a webform role permission to place only webform-provided blocks.
- Combine per-theme and per-provider permissions for precise delegation, e.g. Olivero + `block_content` only.
- Audit which roles can edit which block families by diffing role permission lists.
- Keep block configuration governed while still handing out `administer blocks`.
- Give a translator role read-only exposure to Block layout by withholding provider permissions.
- Protect commerce or search blocks from accidental removal by editors.
- Scale permissions automatically as new modules add block plugins.
- Lose a permission cleanly when its theme is uninstalled (the callback stops emitting it).
- Grant temporary block access for a launch and revoke it by removing one permission.
- Enforce that the admin theme's block layout can only be changed by developers.
- Let a "microsite owner" role manage blocks only in their own theme.
- Provide a safe Block layout experience for training or sandbox environments.
- Assign permissions through configuration management as part of `user.role.*.yml`.
- Check with `drush role:perm:add` in a deployment script which roles get which block scope.
- Explain a puzzling 403 on `/admin/structure/block` — the default theme's permission is missing.
