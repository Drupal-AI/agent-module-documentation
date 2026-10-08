<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Language Field adds a reusable `language_field` field type so any entity (node, user, term, media…) can store one or more languages as data — independent of the content's own translation langcode.

---

Unlike core's built-in content-language selector, this module lets you attach an ordinary field that records "languages" as values: a person's spoken languages, a document's original language, the languages a service is offered in, and so on. It ships the `language_field` field type plus three widgets (`languagefield_select`, `languagefield_autocomplete`, `languagefield_autocomplete_tags`) and a formatter (`languagefield_default`) that renders each stored code as an ISO code, English name, or native name (and a flag icon when the Language Icons module is present). The set of selectable languages is controlled per field by storage settings: a `language_range` (core configurable languages, locked languages like `und`/`zxx`, all predefined languages, the site default, or the module's own custom languages), plus optional `included_languages`/`excluded_languages` allow/deny lists and a pluggable `allowed_values_function`. The module also defines a `custom_language` config entity so you can register languages that Drupal doesn't ship (e.g. Klingon, a regional dialect) at `/admin/config/regional/custom_language`, each with an English label, native name, direction and weight. Values are plain language codes stored in a `varchar` column, so they integrate with Views, Tokens, Feeds (a Feeds target) and Tamper (a `LanguageToCode` plugin). It is purely additive: enabling it changes nothing until you add a Language field to a bundle.

---

- Record the languages a person speaks on a user profile or staff/contact content type.
- Store the original language of a document, book, or article separate from its translation langcode.
- Tag media items (video, audio) with the language of their content.
- Let editors pick one language from a select list with the `languagefield_select` widget.
- Offer type-ahead language entry with the `languagefield_autocomplete` widget.
- Capture several languages at once (tags-style) with `languagefield_autocomplete_tags`.
- Restrict a field to only the site's configurable languages via the `language_range` setting.
- Offer every ISO predefined language (`LANGUAGES_PREDEFINED`, range `11`) regardless of what the site has installed.
- Include locked languages (`und`, `zxx`) as choices for "not applicable"/"multiple languages".
- Register a custom language such as a constructed or minority language at `/admin/config/regional/custom_language`.
- Give a custom language a native name and RTL/LTR direction for correct display.
- Restrict a field's choices to a specific allow-list with `included_languages`.
- Hide specific languages from a field with `excluded_languages`.
- Display stored languages as their native name (e.g. "Nederlands") using the formatter's `name_native` format.
- Display stored languages as ISO 639 codes for machine-readable output.
- Show flag icons next to languages by combining with the Language Icons module.
- Link each displayed language to its entity with the formatter's `link_to_entity` option.
- Expose the language field in Views, including a dedicated `LanguageFilter` for filtering by stored language.
- Import language values from a feed with the Feeds `LanguageField` target.
- Normalise imported language names to codes with the Tamper `LanguageToCode` plugin.
- Use `languagefield` tokens to print a node/entity's stored language in patterns or templates.
- Provide a multi-value "languages offered" field on a service or product entity.
- Replace a plain text "language" field with a validated, code-backed field.
- Swap the choice source entirely by pointing `allowed_values_function` at a custom callback.
- Grant editors the `administer languagefield` permission to manage the custom-language list.
- Set a maximum stored code length (`maxlength`, default 12) for unusual custom codes.
