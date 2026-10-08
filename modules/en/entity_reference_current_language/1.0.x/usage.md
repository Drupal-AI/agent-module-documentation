<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Current Language adds an entity-reference selection plugin ("Current Language") that limits the entities offered by a reference field to those in the current interface language.

---

Entity Reference Current Language ships a single Entity Reference Selection plugin, `current_language`, that extends Drupal core's Default selection handler. When a reference field is set to use this handler, the candidate list (autocomplete matches, select-list options, and the entities returned when validating input) is filtered to the current language by adding a `langcode` condition to the underlying entity query. A per-field checkbox, "Filter by current language" (on by default), lets you toggle the behaviour without switching handlers. Because it extends the core Default selection handler, it works with any entity type and any reference widget, and it keeps the core access filtering that the Default handler already performs — it simply narrows the offered set to the language of the page the editor is on. It depends only on the core Language module.

---

- Restrict a node reference field so editors only pick nodes that exist in the current content language.
- Keep "Related articles" references consistent with the language of the article being edited.
- Filter a taxonomy term reference so only current-language terms appear in the autocomplete.
- Offer only current-language media items in a media reference field.
- Constrain a "Featured content" field on a language-specific landing page to that language.
- Prevent editors on the German site from accidentally referencing English-only content.
- Make a paragraph's entity-reference subfield language-aware without custom code.
- Limit a menu-content or block reference to the language currently being authored.
- Filter user references by langcode where user entities are language-tagged.
- Reduce noise in long autocomplete result lists by dropping other-language duplicates.
- Ensure translated pages reference their own-language versions of linked content.
- Apply the filter selectively per field by unchecking the box on fields that must stay cross-language.
- Combine with the core Default handler's bundle limits so both bundle and language are enforced.
- Provide language-scoped selection for a "call to action" reference on multilingual campaigns.
- Keep a "Parent page" reference within the same language on a translated content tree.
- Scope a "Sponsors" or "Partners" reference field to the current locale's entries.
- Language-filter an entity reference used inside a Views exposed filter form widget.
- Give content editors on each language site a shorter, more relevant reference picker.
- Enforce single-language references on fields feeding language-specific navigation.
- Filter reference candidates for a commerce product or catalogue field by language.
- Avoid mixed-language reference values in fields that render on translated displays.
- Migrate from custom query alters to a supported, per-field selection setting.
- Toggle the language filter on staging vs. production behaviour by editing one field setting.
- Standardise language-aware selection across many fields by choosing the same handler.
