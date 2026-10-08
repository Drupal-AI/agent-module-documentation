A submodule of Better Entity Reference that demonstrates and stress-tests its public popover JavaScript API from an independent module.

---

Better Entity Reference Demo is reference code for third-party integrators. Enabling it and visiting `/better-entity-reference/demo` shows a fully custom fruit-catalog popover picker composed entirely from the parent module's shared kit (`Drupal.berUI` window/toolbar/search/sort/filter/grid-toggle/list/button, and `Drupal.berTags` tooltips, confirm popovers and drag-reorder). It also proves three extension paths: registering a new component type with `ui.register()`, subclassing the core `Container` class, and listening for `ber-ui:build*` events to add actions to the shipped File/Image/Media widget popovers (`js/extend.js` is a reference for every hook). Finally it ships a self-contained custom field — `DemoFruitItem` (field type `ber_demo_fruit`), `DemoPickerWidget` (`ber_demo_picker`), `DemoElementPickerWidget` (the easy path via the `better_options` element) and `DemoFruitFormatter` (`ber_demo_fruit`, emoji tags) — and its `hook_install` adds a *Demo fruit* field to a `test` content type when one exists. It depends on `better_entity_reference` and is not meant for production.

---

- Learn the Better Entity Reference JS API by reading a working example instead of the source.
- See a complete custom popover built from `ui.window()`, `ui.toolbar()`, `ui.list()` and `ui.button()`.
- Copy the pattern for registering a new kit component type with `ui.register()` / `ui.create()`.
- Copy the pattern for subclassing the framework-agnostic `window.BerUi.Container` class.
- See how to add a button/action to the shipped File, Image and Media widget popovers from an external module via `ber-ui:build` events.
- Reference `js/extend.js` for every documented widget extension hook in one place.
- Study a self-contained custom field (type + two widgets + formatter) that stores ids as JSON in a hidden input for no-JS submit.
- Compare the raw-kit widget (`DemoPickerWidget`) against the element-based easy path (`DemoElementPickerWidget`).
- See drag-reordering wired in a few lines with `Drupal.berTags.components.dragReorder`.
- See the three tooltip attachment styles (`attachLines`, `attachText`, `withTooltip`).
- See confirmation popovers used both directly (`confirm.open`) and via a kit button's `confirm:` option.
- Visit `/better-entity-reference/demo` (permission: access content) to interact with the demo page.
