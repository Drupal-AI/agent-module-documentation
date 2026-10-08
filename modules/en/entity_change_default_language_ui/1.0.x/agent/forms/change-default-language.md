<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Change-default-language forms

Two `FormBase` forms in `src/Form/`, both routed in `entity_change_default_language_ui.routing.yml`
and both requiring `_permission: 'access administration pages'`. Both inject the
`entity_change_default_language_ui.updater` service via `create()`.

## Per-node form — `ChangeDefaultLanguageForm`

- Route `entity_change_default_language_ui.form`, path `/node/{node}/change-default-language`,
  `_admin_route: TRUE`. Form id `entity_change_default_language_ui_form`.
- Reached from the *"Change default language"* node operation added by
  `hook_entity_operation` (see [../api/updater.md](../api/updater.md)).
- `buildForm()` fields:
  - `langcode_to` (`select`, required) — *New original language*; options from
    `Updater::getLanguages()`.
  - `is_create` (`checkbox`, default TRUE) — *Create the translation if not exists*: create a
    translation in the new original language from the current original translation.
  - `langcodes` (`checkboxes`) — *Translations to preserve*; **all translations are removed except
    the ones checked**.
- `submitForm()`: resolves the node with `Updater::getCurrentNode()` (warns "Node not found." if
  absent), reads `langcode_to`, `is_create`, and the checked `langcodes` (filtered with
  `array_filter(..., fn($v) => $v !== 0)`), then calls
  `Updater::update($node, $to, $is_create, $langcodes)` and shows a status message naming the node
  and new langcode. No `validateForm()`.

## Batch form — `ChangeDefaultLanguageBatchForm`

- Route `entity_change_default_language_ui.batch_form`, path
  `/admin/config/regional/change-default-language`. Form id
  `entity_change_default_language_ui_batch_form`. Linked under *Configuration → Regional and
  language* (`.links.menu.yml`, parent `system.admin_config_regional`, weight 1).
- `buildForm()` adds, on top of the per-node fields, `bundle` (`select`, node content type from
  `Updater::getNodeBundles()`) and `langcode_from` (`select`, required — *Actual original
  language*).
- `validateForm()`: rejects the submit if `langcode_from == langcode_to` ("Actual and new original
  languages must be different.").
- `submitForm()`: queries targets with `Updater::getTranslations($from, TRUE, $bundle)`, builds one
  batch operation per `NodeInterface` calling the static `processItem()`, and runs `batch_set()`.
- `processItem()` (static): loads the `entity_change_default_language_ui.updater` service and the
  `entity_change_default_language` logger channel, calls `Updater::update()`, and logs `OK`/`ERROR`
  per node; exceptions are caught and written to the batch message.
- `batchFinished()` (static): reports success plus the count of updated nodes, or an error message.

## Notes

- Both forms operate on **nodes only** and delegate the actual write to `Updater::update()`, which
  forwards to the `entity_change_default_language` API module (see [../api/updater.md](../api/updater.md)).
- The change is **destructive**: switching the original language deletes every translation not
  checked in *Translations to preserve*.
