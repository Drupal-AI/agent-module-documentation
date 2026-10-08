<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Translation Sync (entity_translation_sync) — agent index

Adds an **"Entity translation sync"** tab/operation to configured content entities where an editor
picks translatable fields of the current language and copies their values into the other
translations, in one page. Sync is **manual and per-entity** (a form + batch), not automatic on save.
Depends on core `content_translation`. Core `^9 || ^10 || ^11`.

Configure at `/admin/config/regional/entity-translation-sync` (route
`entity_translation_sync.settings_form`, perm `administer site configuration`). **Clear caches after
enabling/disabling an entity type** — routes, link templates, per-type permissions and the tab are all
derived from config.

- **Enable which entity types / bundles / fields can be synced (config object, schema, PHP/drush, the runtime wiring)** → [configure/settings.md](configure/settings.md)
- **Who may run a sync (static + generated per-entity-type permissions)** → [permissions/permissions.md](permissions/permissions.md)
- **Hooks it implements (link template + entity-operation link + help)** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Config object `entity_translation_sync.settings`, single key `entity_types`; shape
  `entity_types.<entity_type_id>.bundles.<bundle_id>.fields: [field_name, …]`. Ships empty (`{}`).
- Only **translatable** entity types with translatable bundles and translatable fields are offered;
  `entity_reference_revisions` fields (Paragraphs) are excluded.
- Static permission `synchronize any entity translation` (permissions.yml). Per-enabled-type
  permissions like `synchronize node translation` are **generated** by
  `EntityTranslationSyncPermissions::permissions` (a `permission_callbacks:` entry) — grepping the YAML
  alone misses them.
- Link template `drupal:entity-translation-sync` added by `hook_entity_type_alter`; the per-entity
  route `entity.<entity_type_id>.entity_translation_sync` (`<canonical>/entity-translation-sync`) is
  registered at runtime by `EntityTranslationSyncRouteSubscriber` (service
  `entity_translation_sync.route_subscriber`, `RoutingEvents::ALTER` priority `-219`).
- Sync form `Drupal\entity_translation_sync\Form\EntityTranslationSyncForm` (form id
  `entity_translation_sync_form`); settings form `…\Form\SettingsForm` (form id
  `entity_translation_sync_settings`).
- Custom access check service `access_check.entity_translation_sync.synchronize_access_checker`
  (`applies_to: _entity_translation_sync_access`); local-task tab deriver
  `…\Plugin\Derivative\EntityTranslationSyncLocalTasks`; logger channel
  `logger.channel.entity_translation_sync`; CSS library `entity_translation_sync/settings_form`.
- No Drush commands; no plugin type defined (only a local-task deriver).
