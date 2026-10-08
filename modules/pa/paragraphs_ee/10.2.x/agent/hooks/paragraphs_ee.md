<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks

Declared in `paragraphs_ee.api.php`. (The module's own hook *implementations* are OOP attribute
classes under `src/Hook/`; this doc covers the one hook the module invites others to implement.)

## `hook_paragraphs_ee_widget_access($elements, $form_state, $context)`

Lets a module allow or forbid the widget modifications paragraphs_ee makes in
`FormHooks::fieldWidgetCompleteFormAlter()`. All implementations are invoked via
`ModuleHandler::invokeAll()` and OR-combined; if the combined result **is forbidden**,
paragraphs_ee leaves the widget untouched (no categorized dialog, no tiles). Return an
`AccessResultInterface`:

```php
function mymodule_paragraphs_ee_widget_access(array $elements, FormStateInterface $form_state, array $context): AccessResultInterface {
  /** @var \Drupal\entity_reference_revisions\EntityReferenceRevisionsFieldItemList $items */
  $items = $context['items'];
  if ($items->isEmpty()) {
    return AccessResult::forbidden('No items available in widget.');
  }
  return AccessResult::neutral();
}
```

`$context` keys: `form`, `widget` (the Paragraphs widget plugin), `items`
(`FieldItemListInterface`), `default` (bool, dummy form for defaults). `$elements` is the field
widget form as built by `WidgetBase::formMultipleElements()`.

The `paragraphs_ee_sets` submodule implements this hook (`FormHooks::widgetAccess()`) to allow
its enhancements only when the `add_more` element uses the `paragraphs_sets_add_dialog` theme.
