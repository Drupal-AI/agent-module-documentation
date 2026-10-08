<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Render filter: `filter_ck5_webform` (WebformFilter)

`src/Plugin/Filter/WebformFilter.php` — the server-side half that turns the stored embed tag into
an actual rendered webform when content is displayed. This is what you must enable per text format
for embeds to work.

## Plugin definition

- `@Filter` id **`filter_ck5_webform`**, title *"CKEditor 5 Webform Embed"*,
  type `Drupal\filter\Plugin\FilterInterface::TYPE_TRANSFORM_REVERSIBLE`.
- Extends `FilterBase`, implements `ContainerFactoryPluginInterface`.
- DI (`create()`): `entity_type.manager` → `$entityTypeManager`, `renderer` → `$renderer`.
- No settings form, no `defaultConfiguration()` — nothing to configure on the filter itself.

## `process($text, $langcode)`

1. Builds a `FilterProcessResult($text)`.
2. Early return if `$text` is empty or does not contain the substring `drupal-webform` (cheap guard
   so most content skips the regex).
3. `preg_replace_callback()` with pattern
   `/<drupal-webform[^>]*data-webform-id=["\']([^"\']+)["\'][^>]*>.*?<\/drupal-webform>/is`
   — capture group 1 is the webform machine ID from `data-webform-id`.
4. Callback: `load($webform_id)` from the `webform` storage. **Only if the webform exists AND
   `$webform->isOpen()`**:
   - `getViewBuilder('webform')->view($webform)` → render array,
   - `$result->addCacheableDependency($webform)` (so the page's cache clears when the webform is
     edited),
   - `$this->renderer->render($render_array)` → HTML string returned in place of the tag.
5. Anything else (missing ID, closed/scheduled webform) → callback returns `""`, so the tag is
   silently removed.
6. `$result->setProcessedText($new_text)`; return.

## What renders, and access

- `WebformEntityViewBuilder::view()` (in the webform module) simply returns
  `$webform->getSubmissionForm()`, i.e. the standard Webform submission form built through the
  entity form builder. That form applies **Webform's own access rules, handlers, confirmation and
  submission logic** — this module does not re-implement any of that.
- The filter's only gate on rendering is `isOpen()` (open vs closed/scheduled). It does not read
  the current viewer or add its own submission gating; the rendered submission form is responsible
  for that.
- Output HTML comes from the webform view builder / theme, not from concatenating the raw
  `data-webform-id`, so the ID is used only as a load key.

## Enabling

There is no config to import. Per text format (`/admin/config/content/formats`):

1. Add the **Embed Webform** button to the CKEditor 5 active toolbar (see
   [editor.md](editor.md)).
2. Tick **CKEditor 5 Webform Embed** under *Enabled filters* — without it the stored
   `<drupal-webform>` tag is never converted.
3. If *Limit allowed HTML tags* is on, add `<drupal-webform data-webform-id>` to the allowed tags
   so the tag survives filtering. The CKEditor 5 plugin declares this element
   (`elements: - <drupal-webform data-webform-id>` in `ck5_webform.ckeditor5.yml`) and is gated by
   `conditions: { filter: filter_ck5_webform }`, so the toolbar button only appears when the filter
   is enabled on that format.

## Testing reference

`tests/src/Kernel/WebformFilterTest.php` asserts the tag is replaced by the rendered form
(`webform-submission-<id>-form` markup present) and that an unknown ID is removed with no leftover
tag. `tests/src/Functional/WebformEmbedUiTest.php` covers the toolbar/modal UI.
