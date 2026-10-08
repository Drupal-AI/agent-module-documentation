<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Field Widgets provides improved editorial widgets for entity reference fields. It includes a hierarchical taxonomy term selection plugin/widget (constraining autocomplete results to children of a chosen parent term) and an enhancement to the Inline Entity Form (IEF) "complex" widget that adds an autocomplete-driven "create new item" option so editors can add referenced entities more fluidly.
It targets sites that use Inline Entity Form and taxonomy references and want a smoother "add existing or create new" experience directly in the reference field.
---
Install with `composer require drupal/entity_reference_widgets` and enable it; it depends on `field_ui` and `inline_entity_form`. There is no central settings page. Configuration is per field: on a reference field using the IEF complex widget, the module adds third-party settings ("Enable Autocomplete Create Option", helper text, new-item text, submit label) in the widget settings form. When enabled, it attaches the `entity_reference_widgets/ief` library and data attributes that drive the autocomplete-create behaviour client-side.
The hierarchical selection is an `@EntityReferenceSelection` plugin (`erw:hierarchical`) for taxonomy terms that extends core `DefaultSelection` and adds a `parent.target_id` condition based on a configured parent, so the reference field's handler can restrict selectable terms to a subtree. All entity querying goes through core's selection handler, which applies access checks.
---
- Install: `composer require drupal/entity_reference_widgets && drush en entity_reference_widgets -y`.
- Requires `field_ui` and `inline_entity_form`.
- On a term reference field, choose the "Taxonomy Term selection - Hierarchical" reference method.
- Configure a parent term to restrict autocomplete/select results to its children.
- On an IEF-complex reference field, enable "Enable Autocomplete Create Option" in widget settings.
- Provide helper text shown to editors using the create option.
- Customize the "new item" autocomplete label.
- Customize the inline create submit button label.
- Let editors add existing or create new referenced entities from one autocomplete.
- Attach the `entity_reference_widgets/ief` JS only when the option is enabled.
- Use per-field third-party settings — no global configuration to manage.
- Constrain taxonomy references to a subtree without a custom handler.
- Improve UX on Paragraphs/IEF-heavy content types.
- Selection queries run through core's access-checked selection handler.
- Combine hierarchical selection with the IEF create enhancement.
- Keep single-cardinality or multi-value reference fields both supported.
