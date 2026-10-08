CSS Toggle Switch provides an accessible, CSS-only `toggle_switch` Form API element (a styled radios group) plus Better Exposed Filters and Webform integrations.

---

The module wraps the front-end library `ghinda/css-toggle-switch` to turn a standard radios group into an accessible on/off style switch that is styled and animated purely with CSS, so it keeps working without JavaScript and degrades to normal radio buttons. It registers a `toggle_switch` render element that extends core's `Radios`, a companion `toggle_switch_option` element extending `Radio`, and two Twig templates (`toggle-switch.html.twig`, `toggle-switch-option.html.twig`) with matching preprocess hooks. The switch's look and behaviour are controlled entirely by CSS classes you pass in (`switch-light` / `switch-toggle` types plus optional classes such as `switch-candy`, `switch-ios`, Bootstrap/Foundation helpers), so no server configuration object is stored by the base module. It integrates with Views exposed filters through a Better Exposed Filters widget plugin, and an optional `css_toggle_switch_webform` submodule adds "Toggle Switch" and "Entity Toggle Switch" Webform elements. Swipe support is added via the optional `detect_swipe` jQuery library. The base library assets are loaded from a CDN by default but can be served locally by placing them under the site's `libraries/` directory.

---

- Add an accessible, CSS-only on/off switch to a custom form by setting `'#type' => 'toggle_switch'` on a two-option element.
- Replace a boolean radios group (e.g. Active / Closed) with a visually clearer sliding switch.
- Render a switch that still works when JavaScript is disabled, since the states are plain radio inputs.
- Choose between the "light" (`switch-light`) and "toggle" (`switch-toggle`) switch presentations per element via `#toggle_type`.
- Apply library skin classes such as `switch-candy`, `switch-candy-blue`, or `switch-ios` through `#attributes['class']`.
- Style switches with Bootstrap or Foundation helper classes without writing custom CSS.
- Set a custom class on the "on" indicator through `#toggle_on__attributes` to signal the selected option.
- Expose a Views filter as a toggle switch using the Better Exposed Filters "CSS Toggle Switch" widget.
- Let site builders pick the toggle type and extra CSS classes for an exposed filter from the BEF widget settings form.
- Turn a grouped (single-value) exposed filter into a two-state switch in the Views exposed form.
- Add a "Toggle Switch" element to a Webform via the optional Webform submodule.
- Add an "Entity Toggle Switch" Webform element to pick a single referenced entity with a switch UI.
- Configure the Webform toggle element's type, extra classes, and on-attributes from the element edit form.
- Provide a mobile-friendly control with swipe support (via the bundled `detect_swipe` integration).
- Keep switch markup accessible by building on real radio inputs with labels rather than div/JS toggles.
- Serve the switch CSS and swipe JS from your own `libraries/` folder instead of the CDN for offline or CSP-restricted sites.
- Reuse a single consistent switch styling across custom forms, exposed filters, and webforms on one site.
- Prototype settings screens (feature flags, enable/disable options) with a clearer switch affordance.
- Override `toggle-switch.html.twig` in a theme to customise the wrapper markup while keeping the element API.
