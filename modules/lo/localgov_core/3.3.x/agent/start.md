# LocalGov Core — agent index

Foundational helper module for the LocalGov Drupal distribution. Pulls in shared contrib deps
(field_group, linkit, metatag, pathauto, token, role_delegation, image_widget_crop,
media_library_edit) and provides cross-cutting building blocks. No `configure` route, no permissions
of its own, no Drush. Provides config (schema + field storages). Depends on core `block`, `field`,
`node`, `views`, and `field_group`.

- **Services, events & hooks: Page Header event, DefaultBlockInstaller, FieldRenameHelper, `hook_localgov_roles_default`, `hook_localgov_post_install`, `file_link` preprocess** → [api/services.md](api/services.md)
- **Plugins: Page Header block, Powered-by block, `localgov_entity_reference_labels` widget, Linkit matchers, Views page-header display extender** → [plugins/plugins.md](plugins/plugins.md)

Submodules (own docs):
- `localgov_roles` (default editorial roles + `hook_localgov_roles_default`) → [../../modules/localgov_roles/3.3.x/agent/start.md](../../modules/localgov_roles/3.3.x/agent/start.md)
- `localgov_admin_role` (creates an is_admin "LocalGov Admin" role) → [../../modules/localgov_admin_role/3.3.x/agent/start.md](../../modules/localgov_admin_role/3.3.x/agent/start.md)
- `localgov_media` (media types, image styles, crop, linkit config bundle) → [../../modules/localgov_media/3.3.x/agent/start.md](../../modules/localgov_media/3.3.x/agent/start.md)
- `localgov_admin_theme_improvements` (Gin/admin theme CSS/JS fixes) → [../../modules/localgov_admin_theme_improvements/3.3.x/agent/start.md](../../modules/localgov_admin_theme_improvements/3.3.x/agent/start.md)

Key facts:
- Page header block id `localgov_page_header_block`; event `PageHeaderDisplayEvent` (`localgov_core.page_header_display`) with title/subTitle/lede/visibility/cacheTags setters.
- `localgov_core.default_block_installer` reads `config/localgov/block.*.yml` from LocalGov modules.
- `FieldRenameHelper::renameField($old, $new, $entity_type)` — static, for update hooks.
- Ships field storages `localgov_email_address|facebook|phone|twitter|summary` and view mode `node.localgov_card`.
