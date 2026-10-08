<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Revision Manager — agent index

Prunes old **entity revisions** across all revisionable content entity types using pluggable
rules (**`amount`** = keep newest N, **`age`** = delete older than N months), configured per
entity type in `revision_manager.settings` and overridable per bundle. Cleanup is queue-based;
Drush `rm:queue` enqueues everything. Permission `administer revision_manager`.

- **Enable entity types, set Amount/Age defaults, bundle overrides, queueing & logging (config keys)** →
  [configure/settings.md](configure/settings.md)
- **The `RevisionManager` plugin type: implement a custom retention rule; how `amount`/`age` decide deletions** →
  [plugins/revision-manager.md](plugins/revision-manager.md)
- **Drush `rm:queue`** →
  [drush/commands.md](drush/commands.md)

Key facts:
- Config object `revision_manager.settings`: `enabled_entities` (map `entity_type => bool`), `defaults` (`entity_type => plugin_id => {id,status,settings}`), `disable_automatic_queueing` (bool), `verbose_log` (bool).
- Bundle overrides = third-party setting `revision_manager` on the bundle config entity (e.g. `node.type.article` → `third_party_settings.revision_manager.<plugin_id>`).
- Plugins: `amount` (`settings.amount`, keep count), `age` (`settings.age`, months). Both enabled ⇒ **conservative**: delete only if *both* agree. Current + forward revisions always kept.
- Cleanup via the `remove_revisions` queue; enqueue automatically on save (unless disabled) or with `drush rm:queue`. Permission `administer revision_manager`. Settings route `revision_manager.settings` at `/admin/config/content/revision-manager`.
