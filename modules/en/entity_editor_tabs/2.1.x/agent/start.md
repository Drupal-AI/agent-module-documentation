# Entity Editor Tabs — agent index

Relabels/reorders entity primary tabs (View / Edit / Layout / Latest version) and entity operation
links when Content Moderation and/or Layout Builder are enabled. No config, no permissions, no Drush,
no config schema. Depends on `entity_route_context`. Effect is automatic once enabled — nothing to set.

- **What it changes, when it triggers, and the service/util API** → [api/behavior.md](api/behavior.md)

Key facts:
- Two hooks only: `hook_local_tasks_alter()` and `hook_entity_operation_alter()`, both forwarded to the
  `Drupal\entity_editor_tabs\EetHooks` service (autowired, public).
- Content Moderation on a bundle → View/Latest-version tab plugin classes swapped to
  `EetCanonicalLocalTask` / `EetLatestLocalTask` (title shows current moderation state).
- Layout Builder overrides on a bundle → Edit tab class → `EetUpdateLocalTask`, Layout tab title →
  "Edit content"; operation links → "Edit metadata" / "Edit <singular label>".
- `EetUtility::isLayoutBuilderOverridable($entityTypeId, $bundle)` = TRUE when the bundle's
  `entity_view_display` has `third_party_settings.layout_builder.allow_custom = TRUE`.
- No customization is applied to a moderated View tab when the entity is already the live/default revision.
