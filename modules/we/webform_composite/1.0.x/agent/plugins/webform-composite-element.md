# The `webform_composite` element plugin

The module ships **one** WebformElement plugin, `webform_composite`
(`src/Plugin/WebformElement/WebformComposite.php`, extends Webform's `WebformCompositeBase`),
with a **deriver** so every saved composite config entity becomes its own placeable element.

## Deriver → one derivative per composite
`src/Plugin/Derivative/WebformCompositeDeriver.php` loads all `webform_composite` entities
(`loadMultiple()`) and emits a derivative per entity, keyed by the composite id, using the
entity `label()`. Plugin ids therefore look like `webform_composite:<composite_id>` and appear
in the element browser under the "Composite elements" category. (Saving a composite clears the
element definition cache — see [../configure/composites.md](../configure/composites.md).)

## Where the sub-elements come from
`getCompositeElements()` returns `getCompositeDefinition()->getElementsDecoded()`, i.e. the
YAML sub-elements stored on the matching config entity (loaded by derivative id). This is what
overriding `WebformCompositeBase` buys: sub-elements come from **config**, not source code.

- `initializeCompositeElements()` initializes the composite's sub-elements and, if available,
  recurses to support managed-file sub-elements (issue #3010135).
- `preview()` renders `#type: webform_composite` with `#webform_composite` = plugin id.
- `finalize()` rewrites `#type` from the derivative id back to the base `webform_composite`
  and records the plugin id under `#webform_composite` (handling the `webform_multiple`
  multi-value wrapper case too), so the render element resolves the right composite.

## Render element — `src/Element/WebformComposite.php`
A `@FormElement("webform_composite")` extending `WebformCompositeBase`. Its static
`getCompositeElements()` swaps `#type` (`webform_composite`) for the concrete
`#webform_composite` plugin id, gets the element instance from
`plugin.manager.webform.element`, and returns that instance's composite sub-elements. Adds
`#theme => 'webform_composite'`.

## Theming
`hook_theme()` registers `webform_composite`; `template_preprocess_webform_composite()` copies
accessible child elements into `content` and sets `flexbox` from `#flexbox`. A theme suggestion
`webform_composite__{composite_id}` is added, so a single composite can have its own template.
Default template: `templates/webform-composite.html.twig`.

## Placing / using
No API to call — add the composite as an element on any webform via the normal Webform element
browser; enable multiple values for a repeating list. Definitions live entirely in config.
