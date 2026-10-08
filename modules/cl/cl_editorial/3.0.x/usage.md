<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Component Libraries: Editorial (cl_editorial) is a developer toolkit that gives other modules the shared building blocks for low-code UIs around Single Directory Components (SDC): a component-picker form element, a schema-driven props/slots form generator, and a component manager that ignores the active theme.

---

The module ships no end-user configuration (`configure` is null) — it is a library other modules build on. It provides a Form API element `cl_component_selector` (`ComponentSelectorElement`) that renders a searchable radio list of SDC components with thumbnails and README docs, filterable by allowed/forbidden ids and lifecycle status. It provides the `NoThemeComponentManager` service, which decorates core's SDC `ComponentPluginManager` to list/filter components independent of the active theme (resolving `replaces` overrides). The helper function `cl_editorial_component_mappings_form()` (backed by `ComponentInputToForm` and the `cl_editorial.form_generator` = `SchemaForms\Drupal\FormGeneratorDrupal` service) turns a component's JSON-schema props into form fields and adds a `text_format` element per slot, with optional token support. A reusable `ComponentFiltersFormTrait` builds the allowed/forbidden/status filter sub-form, and `Util::isPropOrSlot()` classifies a component input. It also defines two theme hooks (`cl_component_selector`, `form_element__radio__cl_component`) with templates, and bundles a demo SDC `cl_editorial:component-card`. It bundles the submodule **sdc_tags** (Single Directory Components: Tagging). Depends on core `serialization`; the props form generator relies on the `SchemaForms`/`Shaper` PHP libraries, and `league/commonmark` is optional for Markdown docs.

---

- Add a "pick an SDC component" widget to a custom module's form with the `cl_component_selector` element.
- Restrict a component picker to an allow-list (or hide a forbidden list) of components for a given context.
- Filter selectable components by lifecycle status (stable, experimental, deprecated, obsolete).
- Generate an editor form for a component's props automatically from its JSON schema.
- Add a rich-text (text_format) field per component slot so editors can fill slot content.
- List every SDC component on the site regardless of which theme is active (via `NoThemeComponentManager`).
- Build a block, paragraph, or field widget that stores a chosen component id plus its prop/slot input.
- Reuse `ComponentFiltersFormTrait` to give any settings form the allowed/forbidden/status filter UI.
- Render a component card (thumbnail, name, status, description) with the bundled `cl_editorial:component-card` SDC.
- Show component README documentation (Markdown via league/commonmark) inside a picker.
- Classify a mapped input as a prop or a slot with `Util::isPropOrSlot()`.
- Provide token support in component mapping forms when the Token module is present.
- Power a page-building or layout tool that composes SDC components without code.
- Tag components so other modules understand them, using the bundled sdc_tags submodule.
- Offer a searchable, thumbnail-driven component browser in an admin UI.
- Keep component selection consistent across multiple site-building tools by sharing one element.
- Validate that a stored component id still exists at form submit (element validation).
- De-duplicate component definitions that declare `replaces` to override another component.
- Feed a component's schema into a Shaper/SchemaForms-based form generator.
- Give a low-code editorial team a curated subset of components per content type.
- Serve as the shared dependency for the CL/Component Libraries ecosystem of modules.
- Attach the module's CSS/JS (options-filter, filter-settings) to component selection UIs.
