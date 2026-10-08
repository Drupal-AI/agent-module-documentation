# The `paragraph_entity_form` Entity Browser widget

`src/Plugin/EntityBrowser/Widget/ParagraphEntityForm.php` — the module's only PHP plugin. It is an
**Entity Browser widget** (`@EntityBrowserWidget(id = "paragraph_entity_form", auto_select = FALSE)`)
extending `Drupal\entity_browser_entity_form\Plugin\EntityBrowser\Widget\EntityForm`. You do not
normally subclass it; it is instantiated by the shipped `paragraph_items` entity browser.

## Behaviour

- `defaultConfiguration()`: `entity_type => 'paragraph'`, `submit_text => 'Save paragraph'` (plus parent).
- `buildConfigurationForm()`: adds a "Bundle" select to the widget config form.
- `getForm()` drives a **two-step** flow keyed on `configuration['bundle']`:
  - Bundle `'0'` (nothing chosen) → `entitySelectorForm()` renders an **icon grid** of allowed
    paragraph bundles as `image_button`s (`data-paragraph-bundle` attribute). Allowed bundles come
    from the embed button's `bundles` setting via `getAllowedBundles()`; each button uses the
    paragraph type's icon file (thumbnail image style) or the module's default `paragraph_thumb.png`.
  - A chosen bundle → builds an `inline_entity_form` element (`#op: add`) for that paragraph type and
    a submit wired with `#ief_submit_trigger`/`#eb_widget_main_submit` and Inline Entity Form's
    `ElementSubmit::trigger`.
- `getAllowedBundles($allowed)` intersects all paragraph bundles with the embed button's allowed
  list (preserving order) and enriches each with its label.

## Extending

To constrain or reorder embeddable bundles, set the embed button's `type_settings.bundles` (config),
not code. To change the create form used, set the widget's `form_mode`. Because it extends the
generic `EntityForm` widget, standard Entity Browser widget configuration keys apply.
