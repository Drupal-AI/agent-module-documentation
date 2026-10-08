Translation Views adds Views **fields and filters** that expose per-row translation information (status, target language, outdated flag, translation count, operation links) so you can build translation dashboards and queries for any translatable entity.

---

The module works via `hook_views_data_alter()`: for every entity type that has a Views data handler, is translatable, and has content_translation enabled, it adds two virtual Views tables - `{entity}_translation` and `{entity}_translation_target` - joined to the base data table by a custom join plugin (`translation_views_language_join`). These tables provide fields/filters keyed on a chosen **target language** (an exposed filter, `translation_target_language`, identifier `translation_target_language`): whether the row is translated into the target (`translation_views_status`), the target-language "outdated" flag, translation changed time, whether target equals the row's default language, whether the source translation equals the row language, translation **operation links** (add/edit in target), moderation state, and a **translation counter** (with an option to include the original language). A runtime `hook_views_query_substitutions()` swaps the placeholder tokens `***TRANSLATION_VIEWS_TARGET_LANG***` / `***TRANSLATION_VIEWS_TARGET_LIMIT_LANG***` for the selected langcode. It ships a demo view (`content_translations`, config/optional) at path `translate/content` - the "Content translation jobs" list - that you can copy for other entity types. There is no settings form (`configure=null`), no permissions and no config of its own; everything is done inside the Views UI. Fields/filters only appear for entity types with content translation enabled, so enable translation for the entity type first.

---

- Build a "translation jobs" dashboard listing which nodes still need translating into French.
- Add an exposed "Target language" filter so editors pick which language to review.
- Show a translation-status column (translated / not translated into the target language).
- Flag rows whose target-language translation is outdated and needs re-translation.
- Add "Translate" / edit operation links that jump straight to the target-language edit form.
- Count how many translations each source item has (optionally including the original).
- Filter a list to rows that have fewer than N translations (find under-translated content).
- Show the translation "changed" time in the target language.
- List content where the target language equals the original language (nothing to translate).
- Build per-language editorial queues from one reusable view.
- Reuse the shipped `content_translations` view at `/translate/content` as a starting point.
- Create a translation dashboard for custom translatable entities (media, taxonomy terms, etc.).
- Display translation moderation state (with Content Moderation) alongside status.
- Filter rows where the source translation of the row equals the target language.
- Give translators a filtered worklist scoped to their language.
- Combine translation fields with normal node fields (title, author) in one table.
- Export a report of untranslated content per language.
- Drive a block that shows how much content is translated into each language.
- Add a bulk-operations view for translating many items (with VBO).
- Surface outdated translations across the whole site in one view.
- Compare translation coverage between two languages.
- Provide a "needs review" queue using the outdated + status filters together.
- Build language-specific landing pages of recently translated content.
