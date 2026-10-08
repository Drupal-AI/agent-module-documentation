<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `entity_translations` Views field

## Adding it

1. Enable the module. Because it depends on `config_rewrite`, enabling ships a rewrite of the
   core `views.view.content` config that pre-adds the field to the admin Content view at
   `/admin/structure/views/view/content`, so on a fresh install the column appears there
   automatically.
2. To add it elsewhere: edit any entity View, "Add" a field, and pick **"Entity translations
   field"** (help text: "Displays all available translations and a quick way for adding the
   unexisting ones."). It is offered on the base table of every entity type
   (`hook_views_data_alter()` registers `translation_button` on each), so it works on node,
   media, taxonomy term, user, etc. Views.

## What it renders per row

For each **enabled language** the field emits at most one link:

| Row state for that language | Link title | Route |
| --- | --- | --- |
| Entity **has** the translation | `Edit {langcode} translation` | the translation's `edit-form` |
| Entity is translatable, translation **missing** | `Add {langcode} translation` | `entity.<entity_type>.content_translation_add` (`source` = entity's language, `target` = langcode) |
| Entity not translatable | *(nothing for that language)* | — |

Existing-translation links carry classes `{langcode}-has-translation language-has-translation`;
add links carry `language-add-translation`. The bundled CSS
(`views_entity_translations_links/views.entity.translations.links`) turns these plus per-langcode
classes into country-flag icons (`images/<cc>.png`), so the column reads as flags rather than text
(the visible text is off-screened via `text-indent`).

## Header

The field's own `label()` returns a placeholder string; `hook_preprocess_views_view_table()`
overwrites the column header, for the **table** style only, with a row of flag spans (one per
enabled language, class `langcode-<code> language-flag`). If you use a non-table Views style the
header is not specially rendered.

## Options

- **Include destination** (`destination`, default on): appends a `destination` query parameter to
  each link (via `RedirectDestinationTrait::getDestinationArray()`) so that after the editor saves
  the add/edit form they are returned to the originating View. Uncheck to send them to the form's
  own default redirect instead.

## Behaviour notes

- `clickSortable()` is FALSE — the column is not sortable.
- `query()` deliberately skips `parent::query()`; when the site is multilingual it lets
  `EntityTranslationRenderTrait` add the correct translation-aware query behaviour, so rows resolve
  to the right entity language. On a single-language site the field still renders (only the one
  language column appears).
- The field needs the row's entity object (`$values->_entity`), so use it on a View whose rows are
  entities (the default entity Views rows), not on an aggregated/rendered-value query.
