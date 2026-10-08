<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How a preview is produced

1. **Button** — `ParagraphsPreviewerWidgetTrait::formElement()` adds a `#type: submit` element
   named `<parents>_previewer` with `#submit => [submitPreviewerItem]` and an `#ajax` callback.
2. **Submit** — `submitPreviewerItem()` only calls `$form_state->setRebuild()`, so the
   in-progress (unsaved) paragraph values are re-cached in the form cache.
3. **AJAX response** — `ajaxSubmitPreviewerItem()` builds
   `Url::fromRoute('paragraphs_previewer.form_preview', ['form_build_id' => $form['#build_id'],
   'element_parents' => implode(':', $element_parents)])` and returns an
   `OpenModalDialogCommand` whose content is the theme hook
   `paragraphs_previewer_modal_content` (an `<iframe src="{{ preview_url }}">`).
   Dialog options: `dialogClass: paragraphs-previewer-ui-dialog`, `width: 98%`, `height: 400`,
   `minWidth: 320`, `modal`, `draggable`, `resizable`, `autoResize: FALSE`.
   The dialog title is the paragraph type title taken from
   `$element['top']['paragraph_type_title']['info']['#markup']`, else "Preview".
4. **Controller** — `ParagraphsPreviewController::onForm($form_build_id, $element_parents)`:
   - explodes `element_parents` on `:`; requires ≥ 2 parts, else `AccessDeniedHttpException`;
   - `\Drupal::formBuilder()->getCache($form_build_id, $form_state)` → the cached form;
   - pops delta + field name, reads `WidgetBase::getWidgetState(...)['paragraphs'][$delta]['entity']`
     to get the unsaved `Paragraph`;
   - `findParentEntity()` walks back through any `subform` parents so a **nested** paragraph is
     rendered in the context of its parent paragraph, not the node;
   - `paragraphsPreviewRenderParentField()` clones the parent, does
     `$parent_clone->{$field}->setValue([['entity' => $paragraph->createDuplicate()]])` and
     returns `$parent_clone->{$field}->view($view_mode)[0]`;
   - falls back to the markup "No preview available." and always attaches
     `paragraphs_previewer/preview-page`.
5. **Page chrome removal** — `paragraphs_previewer_preprocess_html__paragraphs_previewer()` and
   `…_preprocess_page__paragraphs_previewer()` unset `page_top`/`page_bottom` and every block
   whose `#base_plugin_id` is not `system_main_block`, and add the `paragraphs-previewer` class.

## Programmatic re-use

`ParagraphsPreviewController::paragraphsPreviewRenderParentField(Paragraph $p, string $parent_field_name, ?ContentEntityBase $parent)`
is public and safe to call from your own code to render a single (possibly unsaved) paragraph in
the context of a parent entity's field:

```php
$render = \Drupal::classResolver(\Drupal\paragraphs_previewer\Controller\ParagraphsPreviewController::class)
  ->paragraphsPreviewRenderParentField($paragraph, 'field_page_sections', $node);
```

Nothing else is public API: there are no services, no events and no hooks invited by this module.
