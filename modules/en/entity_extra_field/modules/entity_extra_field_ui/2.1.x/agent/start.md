<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Extra Field UI — agent index

Admin UI for the parent [entity_extra_field](../../../../2.1.x/agent/start.md) module. Depends on `field_ui` + `entity_extra_field`. No config, plugins, permissions, or Drush of its own — it reuses the parent's `administer entity extra field` permission and `entity_extra_field` config entity.

What it wires up:
- **RouteSubscriber** (`src/Routing/RouteSubscriber.php`): for each entity type with a `field_ui_base_route`, mounts routes `entity.<entity_type>.extra_fields` (collection), `.add`, `.edit`, `.delete` under that bundle's Field UI path.
- **`hook_entity_operation()`** (`entity_extra_field_ui.module`): adds the "Manage extra fields" operation to bundle entities for users with `administer entity extra field` (only when the bundle has Field UI).
- **Derivers**: `MenuLinksTask` (local tasks), `MenuLinksAction` (add action link), `TranslateLocalTask` (config-translation tab).
- **Config translation**: `entity_extra_field_ui.config_translation.yml` registers the `entity_extra_field.extra_field` mapper (`EntityExtraFieldMapper`).

Note: safe to disable in production once extra fields exist — the fields keep working because they are the parent module's config entities. All actual field-type config lives in the parent's docs.
