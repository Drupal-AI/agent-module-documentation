Webform Composite Tools lets site builders define reusable custom composite webform elements through an admin UI (config entities) instead of writing PHP, then place them like any other element on any webform.

---

Core Webform supports composite elements (a single element that bundles several sub-fields, e.g. name + email + phone), but building a new reusable composite normally requires a custom module with a `WebformCompositeBase` plugin in code. This module removes that barrier by defining a `webform_composite` config entity whose sub-elements are stored as YAML in configuration. Each saved composite is exposed to Webform as a derivative of a single `webform_composite` WebformElement plugin (via `WebformCompositeDeriver`), so it appears in the element browser and can be added to any form, made multi-value, and themed. Composites are managed at `/admin/structure/webform/config/composite` with add/edit/source/delete routes, all gated by the core `administer webform` permission. The edit form uses Webform's `webform_element_composite` builder UI for sub-elements; a separate Source form lets you edit the raw YAML directly in a CodeMirror editor. Saving a composite clears the Webform element plugin definition cache so the new/updated derivative is picked up immediately. Element `#states` data is stripped on decode to avoid unexpected behavior. It depends only on Webform and requires no separate PHP or Composer dependencies.

---

- Define a reusable composite element (e.g. address, name, or contact block) without writing a custom module.
- Bundle several sub-fields into one element that can be dropped onto any webform.
- Manage all reusable composites from one admin list at `/admin/structure/webform/config/composite`.
- Build a composite's sub-elements visually with Webform's composite element builder UI.
- Edit a composite's element definition as raw YAML via the Source form.
- Share a single "customer contact" composite across many different webforms.
- Standardize an address block once and reuse it site-wide.
- Add a composite element and enable multiple values to collect a repeating list of entries.
- Give each composite a human-readable label plus an administrative description.
- Assign a stable machine name so a composite is referenceable and config-exportable.
- Export composite definitions with configuration for deployment across environments.
- Update a composite once and have every webform using it reflect the change.
- Theme a specific composite with its `webform_composite__{id}` template suggestion.
- Lay out composite sub-elements in flexbox columns via the `#flexbox` property.
- Preview a composite element in the Webform element browser before placing it.
- Include select/options sub-fields inside a composite (options are validated as required).
- Prevent duplicate sub-element keys through built-in edit-form validation.
- Create a composite from scratch, then fork/adjust its YAML per site needs.
- Provide non-developers a UI to create form building blocks normally reserved to coders.
- Keep composite element definitions in version-controlled config rather than in code.
- Delete a reusable composite when it is no longer needed via the delete form.
- Convert a repeated group of fields you keep re-adding into one maintainable element.
- Collect structured multi-part data (like emergency contacts) as a single element.
