<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Entity Translations Links adds a Views field that renders, for each row's entity, one link per enabled language: an "Edit" link when the translation exists and an "Add" link when it does not, styled as flag buttons.

---

The module registers a single Views field, `translation_button` (plugin id `entity_translations`), against the base table of every entity type via `hook_views_data_alter()`, so it can be added to any entity View. When a row is rendered, the field's `render()` loops over every enabled language: if the row entity already has a translation in that language it emits an "Edit {langcode} translation" link pointing at that translation's `edit-form` route; if the entity is translatable but lacks the language it emits an "Add {langcode} translation" link pointing at the entity type's `content_translation_add` route with `source` set to the entity's language and `target` set to the missing langcode. Existing-translation links get a `{langcode}-has-translation` / `language-has-translation` class and missing ones a `language-add-translation` class; a bundled CSS library maps those classes plus per-langcode classes to country-flag PNGs, so the column reads as a grid of flags. A `hook_preprocess_views_view_table()` implementation replaces the field's table header with a row of language-code flag spans. The field carries one option, "Include destination" (on by default), which adds a `destination` query parameter so the editor returns to the listing after saving. The module depends on `config_rewrite` purely to ship a rewrite of the core `views.view.content` config that pre-adds this field to the admin Content view; enabling the module makes the field appear there, and it can be added to other Views by hand. It has no configuration form, no permissions, and no schema of its own. Core requirement is `^8.8 || ^9 || ^10 || ^11`; the current release is 2.1.0.

---

- Add a translation-status column to the admin Content view.
- Show at a glance which languages each node already has.
- Jump straight from a listing to editing an existing translation.
- Jump straight from a listing to adding a missing translation.
- Give translators a per-row, per-language work queue.
- Speed up clearing a large translation backlog.
- Reduce navigation clicks between the listing and each node's Translations tab.
- Build a multilingual editorial dashboard as a View.
- Display translation coverage per row in a custom report View.
- Add the field to a Views page other than the default Content view.
- Add the field to a media or taxonomy-term View (any entity type's base table).
- Return the editor to the source listing after saving via the destination parameter.
- Render language buttons as country flags out of the box.
- Prioritise untranslated content by scanning the flag grid.
- Track a translation project's progress in-line.
- Support a four-language site's editorial workflow.
- Surface the content_translation add/edit routes without opening each node.
- Replace the per-node Translations overview walk with a single listing.
- Give an agency team a shared view of what still needs translating.
- Combine with Views filters (e.g. default language) to scope the work list.
