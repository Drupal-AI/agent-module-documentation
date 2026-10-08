<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Output filter & entity-presave cleanup

Two server-side pieces remove the editor-only control markup that the CKEditor 5 widget emits, so
only structural column HTML plus the responsive CSS reach the rendered page.

## Filter plugin `filter_ck5_column_layout`

`src/Plugin/Filter/FilterColumnLayout.php`, `class FilterColumnLayout extends FilterBase`.

- `@Filter` id `filter_ck5_column_layout`, title *"CKEditor 5 Column Layout Asset Loader & Cleaner"*,
  description *"Removes editor-only attributes and attaches CSS."*, type
  `FilterInterface::TYPE_TRANSFORM_REVERSIBLE`.
- `process($text, $langcode)` returns a `FilterProcessResult`. **Early return** (no changes) when
  `$text` is empty or does not contain the substring `cl-flex` — so non-column content is untouched.
- When column markup is present it, in order:
  1. Removes `span` elements carrying `data-cl-marker` (the row-controls / add-col / item-del
     markers the JS dataDowncast inserted).
  2. Strips `contenteditable`, `role`, and `data-ck-*` attributes.
  3. Strips these tags (open+close and self-closing): `script`, `object`, `embed`, `applet`,
     `style`.
  4. Removes inline `on...="..."` / `on...='...'` event-handler attributes (quoted values, via a
     backreference to the opening quote).
  5. **Clamps** `data-xs|sm|md|lg`: keeps the value only if it matches `^[1-6]$`, otherwise forces
     it to `"1"`.
  6. Strips `contenteditable` / `role` again (cleanup pass).
- Then `setProcessedText(trim($text))` and
  `addAttachments(['library' => ['ck5_column_layout/editor']])` — this is how the responsive column
  CSS is loaded on the front end (only when column markup exists).

This filter is a *cleanup / asset-loader* pass, not the format's primary HTML sanitizer. `hook_help`
instructs admins to enable it **and to order it after core's *Limit allowed HTML tags*** filter,
which remains the real allowed-tag boundary. The plugin's `drupal.elements` only whitelist
structural `div` markup (class + data-attrs), so the module does not itself widen a format to permit
scriptable tags.

## `hook_entity_presave` (`ck5_column_layout.module`)

`ck5_column_layout_entity_presave(EntityInterface $entity)` — runs on save, before the output
filter, as a persistence-time normalizer:

- Skips non-`ContentEntityInterface`.
- For each field of type `text`, `text_long`, or `text_with_summary`, on each delta whose `value`
  contains `cl-flex`, it `preg_replace`s the editor control wrappers with marker spans:
  `div.cl-flex-row-controls` → `<span data-cl-marker="row-controls">`,
  `div.cl-flex-add-col-wrapper` → `<span data-cl-marker="add-col">`,
  `span.cl-flex-item-del` → `<span data-cl-marker="item-del">`, then strips `contenteditable` /
  `role`. The stored markers are later removed by the filter at render time.

## Test

`tests/src/Kernel/ColumnLayoutFilterTest.php` exercises the filter's transform behavior.
