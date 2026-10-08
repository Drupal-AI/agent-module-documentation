# The `paragraph_entity_form` Entity Browser widget

`src/Plugin/EntityBrowser/Widget/ParagraphEntityForm.php` — the module's only PHP plugin. It is an
**Entity Browser widget** (`@EntityBrowserWidget(id = "paragraph_entity_form", auto_select = FALSE)`)
extending `Drupal\entity_browser_entity_form\Plugin\EntityBrowser\Widget\EntityForm`. You do not
normally subclass it; it is instantiated by the shipped `paragraph_items` entity browser. Its
constructor adds `extension.list.module` (to resolve the default icon path) on top of the parent's
services.

## Behaviour

- `defaultConfiguration()`: `entity_type => 'paragraph'`, `submit_text => 'Save paragraph'` (plus parent).
- `buildConfigurationForm()`: adds a "Bundle" select to the widget config form.
- `getForm()` drives a **two-step** flow keyed on `configuration['bundle']` (updated from
  `selected_bundle` user input):
  - Bundle `'0'` (nothing chosen) → `entitySelectorForm()` renders an **icon grid** of allowed
    paragraph bundles as `image_button`s (each carries a `data-paragraph-bundle` attribute; the
    dialog JS copies it into the hidden `selected_bundle` on click). Each button uses the paragraph
    type's icon file rendered through the `thumbnail` image style, or the module's default
    `images/paragraph_thumb.png`.
  - A chosen bundle → attaches the `dialog` library, then builds an `inline_entity_form` element
    (`#op: add`, `#entity_type`, `#bundle`, `#form_mode`) for that paragraph type and a submit wired
    with `#ief_submit_trigger` / `#ief_submit_trigger_all` / `#eb_widget_main_submit` and Inline
    Entity Form's `ElementSubmit::trigger`. The actual entity build and save are delegated to Inline
    Entity Form + the parent `EntityForm` widget — this class defines no custom `submit()`/save path.
- **Allowed bundles** come from the embed button's `type_settings.bundles`. `entitySelectorForm()`
  finds that embed button from the request path
  (`/entity-embed/dialog/<format>/<button>` → `$path_parts[3]`) and, if that fails, falls back to the
  entity-browser widget context's `embed_button_id`. `getAllowedBundles($allowed)` intersects all
  paragraph bundles with that list (preserving order) and enriches each with its label
  (`props['label']` or `ucfirst($bundle)`).

## Extending

To constrain or reorder embeddable bundles, set the embed button's `type_settings.bundles` (config),
not code. To change the create form used, set the widget's `form_mode`. Because it extends the
generic `EntityForm` widget, standard Entity Browser widget configuration keys apply.
