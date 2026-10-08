# Breadcrumb Manager — agent index

Path-based breadcrumb builder (replaces core's, priority 9000) that resolves each URL segment's
title through a weighted chain of title-resolver plugins. One config form; one permission; one
plugin type; two alter hooks.

- **All settings + the config form + config keys** → [configure/settings.md](configure/settings.md)
- **`breadcrumb_title_resolver` plugin type (shipped resolvers + writing one)** →
  [plugins/title-resolver.md](plugins/title-resolver.md)
- **Alter hooks (`_path_alter`, `_fake_segments_alter`, resolver-info alter)** →
  [hooks/hooks.md](hooks/hooks.md)

Submodule (own docs):
- `breadcrumb_manager_context` (title resolver from the Context module) →
  [../../modules/breadcrumb_manager_context/1.5.x/agent/start.md](../../modules/breadcrumb_manager_context/1.5.x/agent/start.md)

Key facts:
- Service `breadcrumb_manager.breadcrumb` (`BreadcrumbManagerBuilder` extends core
  `PathBasedBreadcrumbBuilder`), tagged `breadcrumb_builder` priority 9000.
- Config `breadcrumb_manager.config`; form at
  `/admin/config/user-interface/breadcrumb-manager`, route
  `breadcrumb_manager.breadcrumb_manager_config_form`, permission `administer breadcrumb manager`
  (not `restrict access: true`).
- Plugin manager `plugin.manager.breadcrumb_title_resolver`; resolvers in
  `Plugin/BreadcrumbTitleResolver/`: `menu_link_title`, `request_title`, `raw_path_component`.
- Dedicated cache bin `cache.breadcrumb_manager` (used by the context submodule).
