Form Options Attributes is a developer-only Form API helper that lets you attach arbitrary HTML attributes (classes, `data-*`, `title`, etc.) to the *individual* options of `select`, `radios`, and `checkboxes` elements via a new `#options_attributes` render-array property.

---

Drupal core's Form API lets you put `#attributes` on a form element as a whole, but gives you no way to add attributes to a single `<option>` inside a `<select>`, or to one radio/checkbox within a group. This module fills that gap. Enable it, then add an `#options_attributes` array to any `select`, `radios`, or `checkboxes` element; its keys mirror the element's `#options` keys, and each value is an attributes array formatted exactly like `#attributes`. For `select`, it swaps in a dedicated theme suggestion (`select__form_options_attributes`) and template that prints the per-option attributes; for `radios` and `checkboxes` it registers a `#process` callback (via `hook_element_info_alter`) that copies the attributes onto each child element's real `#attributes`. Radios and checkboxes additionally support `#options_wrapper_attributes` and `#options_label_attributes` to target each option's wrapper `<div>` and `<label>`. It is a pure API module: no admin UI, no configuration, no permissions, no Drush commands, no plugins, and no dependencies beyond core. You only need it if another module requires it, or if you are coding a custom form (or `hook_form_alter`) that must decorate individual options — for JavaScript hooks, styling, accessibility attributes, or client-side option filtering.

---

- Add a `data-*` attribute to individual `<option>` elements of a `select` so JavaScript can read per-option metadata.
- Give one option a CSS `class` to color-code or icon-badge it in a dropdown.
- Attach `data-price`, `data-sku`, or `data-stock` to product-variant options for client-side price/stock updates.
- Add `disabled` or `hidden` semantics to specific options while keeping the rest selectable.
- Tag geographic options (states, regions) with `class` groupings like `southeast` / `midwest` for styling.
- Store a machine value in a `data-slug` attribute so a script can build a URL when an option is chosen.
- Attach `title` tooltips to individual radio buttons to explain each choice.
- Add per-option `data-*` hooks that a Chosen/Select2-style widget consumes to render icons or descriptions.
- Mark a "recommended" option with a `class` for CSS highlighting in a radios group.
- Add `aria-*` attributes to specific checkboxes for accessibility beyond the group default.
- Apply per-option attributes inside `<optgroup>`s of a select (nested keys: group label then option key).
- Wrap a single checkbox's row with a `data-*` on its wrapper via `#options_wrapper_attributes`.
- Style one radio's `<label>` differently using `#options_label_attributes`.
- Add analytics tracking attributes (`data-track`) to individual options for click/selection instrumentation.
- Encode conditional-logic keys on options so a form's client-side script can show/hide dependent fields.
- Attach `data-color` swatches to color-picker radios rendered as styled buttons.
- Give payment-method radios `data-provider` attributes for a JS payment integration.
- Alter an existing contrib/core form via `hook_form_alter()` to inject `#options_attributes` onto its select without patching that module.
- Add `data-image` URLs to options so a script can preview an image per selection.
- Provide per-option `lang` / `dir` attributes for multilingual option labels.
- Flag deprecated or legacy options with a `class` so CSS can strike them through.
- Attach `data-min` / `data-max` bounds to options that drive another field's validation client-side.
- Add `class` groupings to checkboxes so a "select all in group" script can target subsets.
- Give survey/likert radios `data-weight` attributes for client-side score computation.
- Decorate options with `data-testid` attributes to make automated front-end tests target specific choices.
