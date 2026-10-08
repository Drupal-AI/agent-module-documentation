<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Access Media (adva_media) — agent index

Glue submodule of **adva** (Advanced Access). Its entire code is one plugin class that registers
an **overriding** Access Consumer for core `media`, so adva Access Providers can control access to
Media entities and adva takes over the media access handler. Depends on `adva` + core `media`.
Configured on the shared adva form (`/admin/config/people/adva`, route `adva.settings`). Defines no
own permissions, routes, config schema, services, hooks or drush commands.

- **Turn media access on: enable providers for the `media` consumer, rebuild records, per-type
  bypass permission** → [configure/media-access.md](configure/media-access.md)
- **The `MediaAccessConsumer` plugin: what it registers, the handler swap, bundle (media type)
  support, how to add your own overriding consumer** → [plugins/media-consumer.md](plugins/media-consumer.md)

Parent framework (plugin authoring, grant storage, access handler, query filtering, settings form,
permissions):
- [../../../../1.2.x/agent/start.md](../../../../1.2.x/agent/start.md)
- Access model: [../../../../1.2.x/agent/api/access-model.md](../../../../1.2.x/agent/api/access-model.md)
- Plugins: [../../../../1.2.x/agent/plugins/access-plugins.md](../../../../1.2.x/agent/plugins/access-plugins.md)

Key facts:
- Sole code: `Drupal\adva_media\Plugin\adva\AccessConsumer\MediaAccessConsumer` — annotation
  `@AccessConsumer(id = "media", entityType = "media")`, extends
  `Drupal\adva\Plugin\adva\OverridingAccessConsumer` (empty body; all behavior inherited).
- Because the consumer is *overriding*, `adva_entity_type_build()` swaps the `media` entity type's
  access handler to `Drupal\adva\AdvancedAccessEntityAccessControlHandler`; the original core
  `Drupal\media\MediaAccessControlHandler` is preserved under handler id `adva_access_legacy`.
- Grants for media are stored in the shared `adva_access` table (`entity_type = 'media'`) and
  rebuilt via adva's queue `adva_rebuild_access_records:media` / batch `adva.batch.consumer_access_rebuild`.
- Supports core Media only (Drupal 8.4+); not the contrib Media Entity project (patch in issue
  2971237 for that).
- Configuring providers for `media` makes adva also register the per-type bypass permission
  `bypass adva media access` (defined by the parent module's permission callback).
