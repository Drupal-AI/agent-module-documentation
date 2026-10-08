<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Corresponding Entity References (CER) — agent index

Keeps two entity-reference fields reciprocal: A→B automatically becomes B→A, and unsetting
one side removes the other.

Key facts:

- Configuration is a **config entity type `corresponding_reference`**
  (`cer.corresponding_reference.<id>`), called a **preset**.
  Collection route `entity.corresponding_reference.collection` → `/admin/config/content/cer`.
- Permission: **`administer cer`** (the entity type's `admin_permission`).
- No plugin types, no Drush commands, no services beyond a stub event subscriber, no config
  object (`cer.settings` does not exist).
- Runtime is three hooks in `cer.module`: `hook_entity_insert/update/delete`.
- One alter hook: **`hook_cer_differences_alter()`** (`cer.api.php`).
- **Known bug:** the preset's *Synchronize* form **deletes** the preset
  (`CorrespondingReferenceSyncForm::submitForm()` calls `$this->entity->delete()`).

Docs:

- **Preset shape, all keys, creating/reading presets with drush** →
  [configure/presets.md](configure/presets.md)
- **Sync algorithm, what silently skips a sync, the sync form bug** →
  [api/synchronization.md](api/synchronization.md)
- **`hook_cer_differences_alter()`** → [hooks/cer-differences-alter.md](hooks/cer-differences-alter.md)
- **Permission** → [permissions/administer-cer.md](permissions/administer-cer.md)
