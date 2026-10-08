<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Field Translation Synchronize (ereftras) — agent index

**Copies entity-reference field values from an entity's source translation into its other translations, for fields whose translation was enabled after content already existed.**

- **Version:** 2.0.x (dev-2.0.x checkout; git branch 2.0.x)
- **Core:** ^9 || ^10 || ^11
- **Depends on:** `content_translation`
- **Package:** Devel
- **Configuration:** `ereftras.synchronize_form` → `/admin/config/development/ereftras`
- **Service:** `ereftras.synchronize` (`SynchronizeService::synchronize($entity_type, $bundle, $field_names, $only_empty)`), runs via Batch API and calls `$entity->save()` on each changed translation.
- **Security:** **route `ereftras.synchronize_form` uses `_access: 'TRUE'`** (ereftras.routing.yml:8) — reachable by anyone incl. anonymous — and its submit handler (`SynchronizeForm::submitForm`) mutates and saves entities site-wide through the batch (`SynchronizeService::saveEntities`, `$entity->save()`). Unauthenticated state-mutation / broken access control.

See [api/service.md](api/service.md)
