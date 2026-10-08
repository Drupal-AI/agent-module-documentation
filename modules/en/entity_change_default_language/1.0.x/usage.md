<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Change Default Language provides a service (plus Drush commands and a queue worker) that changes which translation is the *default/original* language of a translatable content entity, promoting an existing (or newly created) translation to be the source language and optionally pruning the others.

---

The module centres on the `entity_change_default_language` service (`EntityChangeDefaultLanguage::update()`), which takes a content entity, a target default langcode, a `$create` flag, and a `$langcodes` list of translations to preserve. It early-returns when the entity is not translatable or already has that default language; otherwise it captures the untranslated original, builds the new default from the target translation's values (or clones the original when `$create` is TRUE and the translation is missing), recurses into `entity_reference`/`entity_reference_revisions` fields to convert referenced entities too, removes and re-adds translations as needed, copies only translatable field values, sets `content_translation_source`, prunes any translation not in `$langcodes`, and saves without creating a new revision (`setSyncing(TRUE)`). A static guard prevents processing the same entity twice per request; exceptions are logged and return FALSE. Two Drush commands wrap it: `ecdl:cdl` (change one entity by type/id) and `ecdl:dlet` (change every entity of a type, optionally by bundle) — the latter enqueues items into the `entity_change_default_language` queue, processed by a QueueWorker on cron (60s/run). There are no routes, permissions, config, or UI; it is a developer/CLI utility.

---

- Change the default (original) language of a single node via `drush ecdl:cdl node 1 es`.
- Promote an existing translation to become an entity's source language.
- Fix content imported under the wrong original language.
- Bulk-convert the default language of every node of a content type (`ecdl:dlet`).
- Bulk-convert default language scoped to one bundle via `--bundle`.
- Preserve the old default language as a translation with `--preserve-legacy-default-language`.
- Keep only a specific set of translations and delete the rest via `--preserve-languages`.
- Delete all other translations by passing an empty preserve list.
- Recursively re-base referenced entities (paragraphs, references) to the new default language.
- Normalize a multilingual site so all content shares a consistent source language.
- Process large sites asynchronously by enqueuing entity-type-wide changes onto cron.
- Call `EntityChangeDefaultLanguage::update()` from custom code to re-base an entity's language.
- Migrate content from a legacy default locale to a new site-wide default.
- Correct entities created before a site's default language was changed.
- Consolidate duplicate content authored under different original languages.
- Re-base a paragraph tree's language alongside its host entity in one call.
- Convert default language without bumping the entity revision (uses syncing save).
- Script a repeatable language-normalization step in a deployment pipeline.
- Preserve editorial history by keeping legacy translations while changing the source.
- Queue-drive default-language changes to avoid PHP timeouts on large content sets.
