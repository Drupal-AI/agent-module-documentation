<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pax tackles a common team pain point: large config entities (entity view/form displays, field configs) produce big single YAML files whose diffs constantly collide in git. Pax "shards" configurable sub-sections of those entities into separate files so concurrent edits touch different files and merge cleanly.

---

The core is `ShardingFileStorage`, a drop-in copy of core's `Drupal\Core\Config\FileStorage` that is `class_alias()`'d early to fully replace the config file storage. `hook_entity_type_build()` marks which config entity paths are shardable via the `PAX_SHARDS` key: `entity_view_display` shards its `content`, `entity_form_display` shards `content` and `third_party_settings.field_group`, and `field_config` shards `settings.handler_settings.target_bundles_drag_drop`. When config is exported, those nested sections are written to their own shard files; on import they are recombined. A Drush command class (`PaxCommands`, `drush.services.yml`) provides CLI support. It has no permissions and no admin UI — it is a developer/deployment-workflow tool that changes how the config sync directory is laid out on disk.

---

- Cut down git merge conflicts on `config/sync` in multi-developer teams.
- Let two developers edit the same view display without colliding YAML diffs.
- Shard `entity_view_display` `content` into per-file pieces for cleaner diffs.
- Shard `entity_form_display` content and field_group third-party settings separately.
- Split `field_config` drag-and-drop target bundle settings into their own shard.
- Keep config exports diff-friendly on large, field-heavy content types.
- Reduce painful rebases when multiple feature branches touch display config.
- Support cleaner code review of configuration changes (smaller, focused files).
- Integrate into CI/CD config workflows via the provided Drush command.
- Recombine shards transparently on config import.
- Replace core `FileStorage` early via class alias, so sharding is automatic.
- Lower the risk of losing config changes during conflict resolution.
- Make Paragraphs/field-group heavy sites' config more manageable in git.
- Improve team velocity by decoupling unrelated config edits.
- Standardize a conflict-resistant config export layout across projects.
