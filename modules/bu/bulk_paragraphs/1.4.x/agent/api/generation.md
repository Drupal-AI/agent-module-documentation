<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk generation flow (routes, form, tempstore, hooks, cron)

All logic lives in `src/Form/BulkGenerateForm.php` and `src/Hook/BulkParagraphsHooks.php`.
No custom entity/plugin/service types; the hooks class is an autowired service
(`bulk_paragraphs.services.yml`) getting the private tempstore factory, messenger, current user,
`logger.channel.bulk_paragraphs`, request stack, entity type manager and time service.

## Install / enable

- `composer require drupal/bulk_paragraphs` then `drush en bulk_paragraphs -y`. Pulls in contrib
  `paragraphs`; core `datetime` is enabled as a dependency.
- Grant the **`use bulk paragraphs`** permission to roles that may mass-create paragraphs.

## Routes & permissions (`bulk_paragraphs.routing.yml`)

- `bulk_paragraphs.generate_form` → `/bulk-paragraphs/generate/{entity_type}/{bundle}/{field_name}`,
  `_form: BulkGenerateForm`, requirement `_permission: 'use bulk paragraphs'`.
- `bulk_paragraphs.settings` → `/admin/config/content/bulk-paragraphs`, requirement
  `_permission: 'administer site configuration'` (see `config/settings.md`).

## Where the UI comes from

`#[Hook('field_widget_complete_form_alter')] fieldWidgetCompleteFormAlter()`:
- Returns early unless the current user has `use bulk paragraphs`, the field is
  `entity_reference_revisions`, the widget is a `ParagraphsWidget`, and its third-party setting
  `bulk_paragraphs.enabled` is TRUE. Also requires cardinality unlimited or > 1.
- For each `add_more_button_<type>` in the widget, builds a modal link (`#type => link`,
  `use-ajax`, `data-dialog-type => modal`) to the generate route with query args
  `paragraph_type`, `field_parents` (comma-joined), `wrapper_id` (from widget state
  `ajax_wrapper_id`). When the widget `add_mode` is `dropdown` and there is more than one type,
  links are wrapped in a dropbutton (`buildBulkDropbutton()`); otherwise individual buttons.
- Injects a hidden submit `bulk_paragraphs_refresh` (class `visually-hidden`) carrying
  `data-entity-type/-bundle/-field-name/-field-parents/-wrapper-id`, with `#ajax` callback
  `ajaxRefreshWidget` and `#submit` `submitRefreshWidget` and `#limit_validation_errors => []`.
- Attaches libraries `bulk_paragraphs/bulk_paragraphs` and `core/drupal.dialog.ajax`.

## The generate form (`BulkGenerateForm`)

- `buildForm($entity_type, $bundle, $field_name, $field_parents, $wrapper_id)` reads the same
  values from route args or query (`getFormParameters()`), reads `paragraph_type` from the query,
  and calls `validateParameters()` (throws `BadRequestHttpException` on bad input — machine-name
  regex `^[a-z0-9_]+$`, entity type must exist, field parents numeric-or-machine-name, wrapper id
  `^[a-zA-Z0-9_\-:.]+$` ≤255). Context is saved in form state key `bulk_paragraphs_context`.
- Fields:
  - Paragraph type: hidden + read-only display when preselected via query
    (`buildPreselectedTypeField()`, uses `#plain_text` label), else a required `select` of allowed
    types (`getAvailableParagraphTypes()` reads the field config `handler_settings.target_bundles`,
    falling back to **all** paragraphs types when the field config or target bundles are absent).
  - `count`: number 1-100, default 10, required.
  - `field_defaults`: per-field inputs built by `buildFieldDefaults()` in form-display weight
    order, only for `FieldConfig` fields shown in the paragraph type's default form display.
- Default-input builders by field type (`buildFieldDefaultElement()` dispatch map):
  datetime/daterange → start date + increment select; integer/decimal/float → start number +
  increment select; string → textfield template; string_long/text/text_long → textarea template;
  text_with_summary → template + summary template; boolean → checkbox; image → managed_file + alt
  template; file → managed_file; list_* → select of allowed values; link → uri + title templates;
  email → email template; telephone → tel template. Unlisted field types are skipped.

## Submit → tempstore

`ajaxSubmit()` (the `Generate` button's `#ajax` callback; plain `submitForm()` is a no-op):
- Reads context, `paragraph_type`, `count`, `field_defaults`.
- `generateParagraphs()` loops `count` times: `$values = ['type' => $paragraph_type]`, then per
  field `calculateFieldValue($field_config, $i)`, then `Paragraph::create($values)->save()`,
  collecting `['target_id', 'target_revision_id']`.
- Stores `['paragraph_ids' => …, 'field_name' => …, 'field_parents' => …]` in the **private**
  tempstore collection `bulk_paragraphs`, key from `getTempStoreKey()`:
  `array_filter([entity_type, bundle, field_name, comma(field_parents)])` joined by `:`.
- Returns an `AjaxResponse` that closes the modal, shows a status message, and invokes JS
  `bulkParagraphsRefresh(wrapper_id)` (in `js/bulk-paragraphs.js`), which clicks the hidden
  refresh button. `ajaxCancel()` just closes the dialog.

## Value calculation (`calculateFieldValue()` and helpers)

- Template fields → `processTemplate()`: `{n}` → 1-based index, `{n0}` → 0-based index,
  `{date:FORMAT}` → `now + index days` formatted (via `preg_replace_callback`).
- text_with_summary → `{value, summary}` from `template`/`summary_template`.
- link → `{uri, title}` (each templated); boolean → cast bool; list → the selected value or NULL;
  image/file → `{target_id: fid[, alt]}` from the managed_file id.
- Otherwise `calculateIncrementValue()`: a `Y-m-d…` start value → `calculateDateValue()`
  (`\DateTime->modify(pattern)` per index, formatted `Y-m-d` for `date` type else `Y-m-d\TH:i:s`);
  a `±N` pattern → `calculateNumericValue()` = `base ± increment*index`.

## Widget refresh & fallbacks

- `submitRefreshWidget()` (static): rebuilds the tempstore key from the button's data-attributes,
  loads the paragraphs, appends them to `ParagraphsWidget::getWidgetState()` (`paragraphs[]`,
  `items_count++`, `real_item_count++`), `setWidgetState()`, `setRebuild()`. It does **not** delete
  the tempstore key. `ajaxRefreshWidget()` returns the widget element to replace.
- `#[Hook('entity_prepare_form')] entityPrepareForm()` is the no-JS / page-reload recovery: for
  `edit`/`default` ops, non-AJAX requests, permitted users, it walks paragraph fields recursively
  (`processParagraphFields()`), reads each tempstore key, appends the stored paragraph refs to the
  field value, and **deletes** the key after reading.

## Cleanup

- `#[Hook('entity_insert')]` / `#[Hook('entity_update')]` → `cleanupTempStoreOnSave()`: after the
  host (non-paragraph) entity saves, deletes tempstore keys for its top-level paragraph fields and
  recurses into nested paragraphs (`cleanupNestedTempStore()`). This is the primary place consumed
  keys are removed.
- `#[Hook('cron')]` → `cleanupOrphanedParagraphs()`: entity query (`accessCheck(FALSE)`) for
  paragraphs with `parent_type = ''` and `created < now-86400`, range 0-100, deletes them and logs
  the count. This reaps generated-but-never-saved paragraphs (and any other parentless paragraph
  older than 24h).

## Diagnostics

- Logger channel `bulk_paragraphs` records warnings for unloadable paragraph ids / empty
  tempstore, info on paragraphs added to widget state and cron reap counts, and errors on
  generation/cleanup exceptions.
