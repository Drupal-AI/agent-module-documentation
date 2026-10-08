<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Content translation access that stores each user's allowed translation languages on a user field and exposes them to the parent module as a LanguageProvider.

---

`content_translation_access_user` is the bundled per-user "assigned languages" source for
Content translation access. On install it adds an entity-reference field **`field_access_languages`**
to the user entity (referencing `configurable_language`, unlimited cardinality, labelled "Languages") and
places its widget on the default user form. Its `UserLanguageProvider` plugin (`id user_language_provider`)
reads the languages selected on the current user's `field_access_languages` and returns them as that user's
assigned translation languages, which the parent module's `AccessControlHandler` uses to gate the
`cta …` translation permissions. A `hook_entity_field_access` implementation restricts editing of the
`field_access_languages` field. Depends on `content_translation_access`, `user` and `language`.

---

- Assign each editor the specific languages they may translate into, directly on their user profile.
- Drive per-user language gating for the parent module's `cta` permissions without custom code.
- Let a French-only translator hold `field_access_languages = [fr]` so they can only act on French.
- Give a multilingual editor several languages at once (unlimited cardinality).
- Combine per-user languages with per-bundle `cta translate <type> <bundle>` permissions.
- Manage a user's allowed languages from the standard user edit form.
- Reference only configured site languages (`configurable_language`) in the field.
- Restrict who may change a user's assigned languages via the field-access hook.
- Provide the "assigned languages" set expected by `AccessControlHandler::hasAssignedLanguage()`.
- Remove the field and its storage cleanly on uninstall.
- Serve as a reference implementation for building an alternative LanguageProvider (role/group based).
- Support both nodes and any other content-translation-enabled entity type via the parent module.
- Scope regional editorial teams by language using ordinary user administration.
- Keep language assignment as content data on the user rather than as extra roles.
