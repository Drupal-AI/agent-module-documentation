<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Translation Sync gives an editor a single page — an "Entity translation sync" tab and entity-operation link on configured content entities — where they tick which translatable fields of the current language to copy into which other translations, then run one batch that writes and saves them. It turns "open five translation edit forms and re-enter the same media/price/date" into one action, without making the field permanently shared.

---

Drupal's `content_translation` decides translatability per field, which sounds like it solves the "same value everywhere" problem but does not: marking a field untranslatable makes it genuinely shared at the schema level and breaks the moment one language legitimately needs to differ, and reversing that is a data migration. This module works at the other end — fields stay translatable, and an editor propagates the configured ones on demand from a per-entity page rather than automatically. An admin first enables entity types, bundles and fields at `/admin/config/regional/entity-translation-sync` (`SettingsForm`, gated by `administer site configuration`), storing the selection in `entity_translation_sync.settings:entity_types` as `entity_types.<type>.bundles.<bundle>.fields[]`; only translatable types/bundles/fields are offered and `entity_reference_revisions` (Paragraphs) fields are excluded. Enabling a type must be followed by a cache rebuild, because the link template (`drupal:entity-translation-sync`, added in `hook_entity_type_alter`), the runtime route (`entity.<type>.entity_translation_sync`, registered by `EntityTranslationSyncRouteSubscriber` on `RoutingEvents::ALTER`), the tab (`EntityTranslationSyncLocalTasks` deriver) and the per-type permissions are all derived from that config. Who may run a sync is controlled by the static `synchronize any entity translation` and the generated per-type `synchronize <type> translation` permissions (from `EntityTranslationSyncPermissions::permissions`, so they will not be found by grepping the YAML). On the sync page (`EntityTranslationSyncForm`) a table shows each configured non-empty field against every other translation language; the editor checks field/language pairs, and a batch copies the current-language value into each selected translation and saves the entity once. Dependency is core `content_translation`; core range `^9 || ^10 || ^11`.

---

- Copy a product price into all of a node's translations at once.
- Push one media/image field to every translation from a single page.
- Keep a date field identical across a node's languages.
- Align an entity-reference (e.g. taxonomy term) across translations.
- Fix drift between translations without opening each translation edit form.
- Avoid marking a field untranslatable permanently just to share it.
- Let one language still deviate later, since fields stay translatable.
- Enable syncing only for chosen entity types (node, media, taxonomy_term…).
- Restrict syncable fields to a curated per-bundle list.
- Grant "Synchronize node translation" to editors who maintain multilingual content.
- Grant "Synchronize any entity translation" to a super-editor role.
- Add an "Entity translation sync" operation link to content listings.
- Add an "Entity translation sync" tab to an entity's canonical page.
- Sync a boolean/flag field across a node's translations.
- Keep shared metadata consistent on a multilingual site.
- Reduce repetitive re-entry for a translation team.
- Batch-update several translations of one entity in a single submit.
- Support custom content entity types that expose a canonical link template.
- Exclude Paragraphs / entity_reference_revisions fields from sync (unsupported).
- Propagate values only where the editor has field edit access.
