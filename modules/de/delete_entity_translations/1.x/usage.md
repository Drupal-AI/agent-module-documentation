Delete Entity Translations gives administrators a single admin form that batch-deletes content entities and their translations for a chosen language across selected entity types.

---

When you delete a language in Drupal, interface (string) translations go away but translated content does not: existing content in that language is silently set to language-neutral rather than removed. Delete Entity Translations closes that gap. It adds one form at `/admin/config/regional/delete-entity-translations` (Configuration → Regional and language) where you pick a language and one or more entity types, then run a Batch API job. For each matching entity the module either deletes the whole entity (when the picked language is the entity's original/default language) or removes just that translation and re-saves (when the language is only a translation). It targets every entity type that declares a `langcode` key, so it works uniformly across nodes, taxonomy terms, media, custom blocks, and other translatable content. The operation is irreversible bulk deletion, is gated behind a dedicated restricted permission, and is typically used as a cleanup step before removing a language entirely.

---

- Delete all content in a language before removing that language from the site.
- Bulk-remove a single translation (for example, drop every French translation) while keeping the original content.
- Clean up abandoned or mistakenly created translations across the whole site in one pass.
- Remove entities whose original language is the one being retired, deleting the entity outright.
- Purge translated nodes for a decommissioned locale.
- Purge translated taxonomy terms for a language you are dropping.
- Purge translated media entities for a retired language.
- Purge translated custom block content for a language being removed.
- Target several entity types at once by multi-selecting them in the form.
- Process large content sets safely via Batch API in chunks of 50 entities.
- Preview scope by picking one entity type at a time before running a broader delete.
- Prepare a multilingual site for consolidation down to fewer languages.
- Undo a bad bulk-translation import by deleting the imported language's content.
- Reset a staging or QA environment's translated content for a given language.
- Free storage by removing stale translations that are no longer maintained.
- Enforce a content policy that a particular language should no longer exist as content.
- Restrict the operation to trusted administrators via the dedicated permission.
- Run the cleanup as a deliberate, backed-up maintenance task rather than per-entity manual deletes.
- Combine with core's Language and Content Translation modules as the final teardown step.
- Verify on a copy of production before running against the live site.
- Keep the module disabled in normal operation and enable it only when a cleanup is needed.
