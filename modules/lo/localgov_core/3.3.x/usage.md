LocalGov Core is the foundational helper module for the LocalGov Drupal distribution: it pulls in shared dependencies (field_group, linkit, metatag, pathauto, token, etc.) and provides cross-cutting building blocks — a configurable Page Header block with an alter event, a default-block installer, a field-rename helper, LocalGov-specific Linkit matchers, and hooks for default roles/blocks.

---

The module ships several reusable pieces rather than one feature. The **Page Header block** (`localgov_page_header_block`) derives a page title/subtitle/lede from the current route's entity or View, and fires a `PageHeaderDisplayEvent` (`localgov_core.page_header_display`) so other modules can override the title, subtitle, lede, visibility, or cache tags; a matching Views **display extender** (`localgov_page_header_display_extender`) lets Views pages feed the header, and theme suggestions like `localgov_page_header_block__{bundle}` allow per-type templates. A **`DefaultBlockInstaller`** service reads `config/localgov/block.*.yml` files from LocalGov modules and places those blocks into theme regions on module install / distribution post-install (`hook_localgov_post_install`). **`FieldRenameHelper::renameField()`** is a static utility that renames an existing field's storage and rewrites all view/form displays and config dependencies (used from update hooks). Two **Linkit matchers** refine autocomplete labels (the node matcher prefixes "Unpublished: " for unpublished nodes). A **`localgov_entity_reference_labels`** field widget renders entity references as reorderable read-only labels (no autocomplete). A "Powered by LocalGov Drupal" block, a `file_link` preprocess that appends file type/size to document links, and theme-setting-driven removal of LocalGov Base CSS/JS round it out. It also declares config (field storages for `localgov_email_address`, `localgov_facebook`, `localgov_phone`, `localgov_twitter`, `localgov_summary`, plus a `localgov_card` view mode). No `configure` route, no permissions of its own, no Drush. Four submodules add default roles (`localgov_roles`), an all-permissions admin role (`localgov_admin_role`), a media configuration bundle (`localgov_media`), and admin-theme tweaks (`localgov_admin_theme_improvements`).

---

- Provide a consistent page-header (title/lede/subtitle) block across a LocalGov site.
- Override a page's header title or lede from custom code via the `PageHeaderDisplayEvent`.
- Hide the page header block on specific routes by setting visibility in an event subscriber.
- Add custom cache tags to the page header from an event subscriber.
- Drive a page header from a Views page using the page-header display extender.
- Theme the page header per content type using `localgov_page_header_block__{bundle}` suggestions.
- Auto-place a module's default blocks into theme regions when the module is enabled.
- Install a distribution's default blocks during LocalGov post-install.
- Rename an existing field (storage + displays + dependencies) safely from an update hook.
- Add a "Powered by LocalGov Drupal" attribution block to a region.
- Render an entity-reference field as reorderable read-only labels (no autocomplete widget).
- Prefix "Unpublished:" on unpublished nodes in Linkit autocomplete results.
- Append file type and human-readable size to document download links.
- Use a media document's description or name as the download link text.
- Strip LocalGov Base CSS or JS via a theme setting for custom theming.
- Provide shared social/contact field storages (email, phone, Facebook, Twitter) to content types.
- Supply a `localgov_card` view mode for teaser/card rendering.
- Bootstrap the common contrib dependency set for a LocalGov build (metatag, pathauto, token, linkit…).
- Grant default LocalGov role permissions to a module's features via `hook_localgov_roles_default()`.
- Create the standard LocalGov editorial roles and an all-permissions admin role (via submodules).
