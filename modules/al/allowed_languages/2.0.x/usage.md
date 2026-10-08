Restricts which languages a user may manage content in, by assigning each user a set of "allowed languages" and blocking edit/delete and translation operations on content in any other language.

---

The module adds an unlimited-cardinality `allowed_languages` entity-reference base field (to `configurable_language`) on every **user** entity, exposed as an "Allowed languages" checkboxes group on the user edit form (with an "Allow all languages" convenience option). Two permissions gate it: `administer allowed languages` controls who can see/set the field on user profiles, and `translate all languages` is a bypass that exempts a user from all restrictions. Enforcement happens in three places: (1) `hook_entity_access()` returns **forbidden** on `update`/`delete` of any translatable content entity whose language is not in the acting user's allowed set; (2) a `ContentTranslationAccessCheck` replaces the core `_access_content_translation_manage` check so add/edit/delete of a translation is only allowed for permitted target languages; and (3) the content-translation overview controller is swapped to strip operation links for disallowed languages. On content **create** forms, a pre-render callback (`languageSelectWidgetPreRender`) removes disallowed options from the language `<select>` widget. A `AllowedLanguages` Views filter ("Current users allowed languages", non-exposable) lets you filter any translatable entity listing down to the current user's allowed languages. The central `allowed_languages.allowed_languages_manager` service resolves a user's assigned languages and answers "may this user manage this language?". There is no admin settings page (`configure` is null) and no config schema — all state is the per-user field value.

---

- Limit a translation editor to only the language(s) they are responsible for.
- Assign one editor to English, another to German, another to French on a multilingual site.
- Block editing of a node whose language the current user is not allowed to manage.
- Block deleting content in a language outside the user's allowed set.
- Restrict the content-translation add/edit/delete operations to permitted target languages.
- Hide translation operation links for disallowed languages on the translations overview page.
- Remove disallowed languages from the language selector when creating new content.
- Grant a trusted lead the `translate all languages` permission to bypass every restriction.
- Delegate management of the allowed-languages field to admins via `administer allowed languages`.
- Let a user manage multiple languages by ticking several boxes on their profile.
- Use the "Allow all languages" checkbox to quickly grant every configured language.
- Add a Views filter that shows each editor only content in their allowed languages.
- Build a per-editor content dashboard scoped to the languages they may touch.
- Enforce language scoping across any translatable content entity type, not just nodes.
- Apply the same restriction to revision listings via the revision-data-table Views filter.
- Programmatically check a user's permitted languages with the allowed_languages_manager service.
- Keep language responsibilities separated in an editorial team without custom code.
- Combine with core content_translation roles to layer language scope on top of translation permissions.
- Cache access results per user so the checks stay performant.
- Assign no languages to effectively lock a restricted editor out of editing translatable content.
