Entity Translate Side by Side provides a single form that shows an entity's fields in several languages next to each other so editors can translate them in one place.

---

Entity Translate Side by Side adds a "Translate side by side" operation to translatable content entities and a dedicated form at `/entity-translate/{entity_type}/{entity_id}`. The form renders each editable, translatable field once per selected language inside a horizontally scrollable (and drag-to-scroll) container, using each entity type's own form-display widgets so text areas, references, booleans and files behave exactly as on the normal edit form. Editors pick which languages to work on via a checkbox panel; the default set comes from the module's configuration (or the entity's existing translation languages when none is configured). On save the module compares each field's new value against the stored value and only writes translations that genuinely changed, so unchanged languages and fields are left untouched — protecting translation history, revision noise and search re-indexing. New translations inherit the publication status of the default translation. Default languages are configured at `/admin/config/system/entity-translate-side-by-side`, and access is controlled by the module's own "Access Entity Translate Side by Side" permission. The module depends on core Content Translation and targets any translatable content entity type.

---

- Translate a node's title and body into several languages on one screen instead of one edit form per language.
- Compare the source-language text with the target-language field while typing the translation.
- Add a brand-new translation for a language directly from the side-by-side form.
- Update an existing translation without opening the standard per-language translation edit form.
- Select exactly which languages to display using the "Select languages to be translated" checkbox panel.
- Refresh the visible language columns with the "Update Languages" button without a full form submit.
- Pre-load a fixed default set of languages for every translator via the admin settings form.
- Fall back to an entity's existing translation languages when no default languages are configured.
- Restrict the language columns for a single visit by passing a `langcodes=de,fr` query parameter.
- Translate custom content entity types (not just nodes) as long as they are translatable.
- Reach the form from the entity list "Translate side by side" operation in the operations dropdown.
- Return to the originating page automatically after saving via the `destination` query parameter.
- Avoid unnecessary revisions/history entries because only actually-changed fields are saved.
- Keep new translations unpublished when the default translation itself is unpublished.
- Keep required fields valid by inheriting the default translation's value when a translation leaves them empty.
- Present fields in the same order as the entity's configured form display (weights respected).
- Skip non-translatable, read-only, computed and base fields automatically so only relevant fields appear.
- Exclude a custom entity type from the operation by implementing `hook_entity_translate_side_by_side_skip_alter()`.
- Give translators one permission ("Access Entity Translate Side by Side") to reach the interface.
- Let administrators jump from the translation form to the default-language settings via an inline link.
- Support drag-and-drop horizontal navigation across many language columns in the scroll box.
- Speed up multilingual editorial workflows for sites with three or more content languages.
- Provide a cleaner alternative to editing each translation separately for editors managing parallel content.
