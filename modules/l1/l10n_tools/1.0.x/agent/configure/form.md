# Admin form (configure)

Route `l10n_tools.form` → **`/admin/config/regional/l10n_tools`** (menu *Configuration › Regional and
language › L10n Tools*), gated by permission **`access l10n_tools form`** (`restrict access: TRUE`).
Form class `Drupal\l10n_tools\Form\L10nToolsForm` (id `l10n_tools_form`) — a plain `FormBase`, not a
`ConfigFormBase`: it saves **nothing**. `getEditableConfigNames()` returns `[]`; every button runs a
`QueryHelper` operation immediately against the database. `submitForm()` only calls
`$form_state->setRebuild(TRUE)` so the dynamically-added delete buttons persist.

The form has three `details` sections (all `#open`). The destructive buttons carry the
`button--danger` class. For the first two sections the delete button appears **only after** you click
the list button first (it is added when `$form_state->getTriggeringElement()['#id']` matches the list
button id). All operations report via `messenger()`; a `FALSE` result → "An error occured, see logs."
(logger channel `l10n_tools`).

## 1. Equal translations
Deletes translations that are byte-identical to their source string (i.e. effectively untranslated
target rows).

- Select `filterCustomized` (`#default_value` `'1'`) — controls `locales_target.customized`:
  - `'1'` → **ONLY user-customized** translations (default)
  - `'0'` → **ONLY default / imported** (from localize.drupal.org) translations
  - empty (the `NULL` option) → **BOTH** imported and customized
- Button `equalSubmitList` (id `equalSubmitList`, *"Show all equal translations (source ==
  translation)"*) → AJAX callback `::getEqualTranslationsAjaxCallback` → renders a `#type table`
  with columns **Lid / Source / Context / Translation** (`#plain_text`, so XSS-safe).
- Button `equalSubmitDel` (*"Clear translations of all listed equal translations"*, appears after
  listing) → submit handler `::deleteEqualTranslationsCallback` → `QueryHelper::deleteEqualTranslations($filterCustomized)`.
  Deletes the matching **`locales_target`** rows only (the source strings stay). Reports a plural
  count of rows deleted.

Note: the empty select value arrives as `""`; the callbacks convert `"" → NULL` before calling
`QueryHelper`. After clearing equal translations, those sources have no target and will show up in
the **Orphan** list below.

## 2. Orphan / Untranslated translations
Deletes `locales_source` strings that have no `locales_target` row at all. The form states this is
**safe** because Drupal rebuilds those source strings on demand.

- Button `orphanSubmitList` (id `orphanSubmitList`, *"Show all orphan / untranslated translations"*)
  → AJAX callback `::getOrphanTranslationsAjaxCallback` → table Lid / Source / Context / Translation
  (translation column is literally `NULL`).
- Button `orphanSubmitDel` (*"Delete all listed orphan / untranslated translation sources"*, appears
  after listing) → submit handler `::deleteOrphanTranslationsCallback` →
  `QueryHelper::deleteOrphanTranslations()`. Deletes the matching **`locales_source`** rows.

## 3. Reset translation status
No list step — a single danger button.

- Button `translationstatusResetDel` (*"Reset translation status"*) → submit handler
  `::resetTranslationStatusCallback` → `QueryHelper::resetTranslationStatus()`. This deletes all
  `key_value` rows in collection `locale.translation_status`, sets `locale_file.timestamp` and
  `locale_file.last_checked` to `0` for every project, and resets state
  `locale.translation_last_checked` to `0`. Reports how many `translation_status` entries were
  removed.
- Link `updateLink` (*"Check available translation updates manually"*, opens `_blank`) → route
  `locale.translate_status`. Use it afterwards to re-check localize.drupal.org for updates.

See [../api/services.md](../api/services.md) for the exact SQL, and
[../drush/commands.md](../drush/commands.md) for the CLI equivalents.
