# The `paragraph_entity_form` Entity Browser widget

`src/Plugin/EntityBrowser/Widget/ParagraphEntityForm.php` — the module's only PHP plugin. It is an
**Entity Browser widget** (`@EntityBrowserWidget(id = "paragraph_entity_form", auto_select = FALSE)`)
extending `Drupal\entity_browser_entity_form\Plugin\EntityBrowser\Widget\EntityForm`. You do not
normally subclass it; it is instantiated by the shipped `paragraph_items` entity browser. It adds a
`ModuleExtensionList` to the parent's constructor (used only to locate the default icon).

## Behaviour

- `defaultConfiguration()`: `entity_type => 'paragraph'`, `submit_text => 'Save paragraph'` (plus parent).
- `buildConfigurationForm()`: adds a "Bundle" container/select to the widget config form.
- `getForm()` drives a **two-step** flow keyed on `configuration['bundle']` (updated from
  `selected_bundle` in the user input); bails out with a "not configured correctly" message if
  `entity_type` or `form_mode` is empty:
  - Bundle `'0'` (nothing chosen) → `entitySelectorForm()` renders an **icon grid** of allowed
    paragraph bundles as `image_button`s carrying a `data-paragraph-bundle` attribute. Each button
    uses the paragraph type's icon file rendered through the `thumbnail` image style, falling back
    to the module's `images/paragraph_thumb.png`.
  - A chosen bundle → builds an `inline_entity_form` element (`#op: add`, `#entity_type`, `#bundle`,
    `#form_mode`) for that paragraph type, plus a submit wired with
    `#ief_submit_trigger` / `#ief_submit_trigger_all` / `#eb_widget_main_submit` and Inline Entity
    Form's `ElementSubmit::trigger`; it sets `drupalSettings.entity_browser_widget.auto_select`.
- **Allowed-bundle resolution** (in `entitySelectorForm()`): the allowed list comes from the embed
  button's `type_settings.bundles`. The button is resolved from the request path when opened from
  the CKEditor toolbar (`/entity-embed/dialog/<format>/<button>` → `$path_parts[3]`), and otherwise
  from the Entity Browser `widget_context['embed_button_id']` when the widget is served from the
  iframe route. If no button is found, `getAllowedBundles(NULL)` returns **all** paragraph bundles.
- `getAllowedBundles($allowed)` intersects all paragraph bundles with the embed button's allowed
  list (preserving the configured order) and enriches each with its label (`ucfirst($bundle)` when
  the bundle has no label).

## Access

The widget builds a standard `inline_entity_form` element with `#op => 'add'`; create access and
field access on the paragraph are enforced by Inline Entity Form / Form API, not re-implemented
here. The widget itself only appears inside the `paragraph_items` browser, whose iframe route is
gated by the `access paragraph_items entity browser pages` permission.

## Extending

To constrain or reorder embeddable bundles, set the embed button's `type_settings.bundles` (config),
not code. To change the create form used, set the widget's `form_mode`. Because it extends the
generic `EntityForm` widget, standard Entity Browser widget configuration keys apply.
