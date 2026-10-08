<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
Extra Field Suite (efs) is a plugin type for building extra pseudo-fields that look and behave like real fields on entity view and form displays but store no data.

---

Extra Field Suite lets developers and site builders add computed or display-only elements to any entity type's Manage display and Manage form display screens. Each element is an "Extra field formatter" plugin (annotation `@ExtraFieldFormatter`, discovered from `Plugin/efs/Formatter`, managed by `plugin.manager.efs.formatters`); a placement is stored as an `extra_field` config entity and rendered through `hook_entity_extra_field_info()`, `hook_entity_view_alter()` and `hook_form_alter()`. Plugins can be configured per display, per view/form mode, and per entity type, each with its own settings form and summary in the Field UI. The module ships several ready-to-use plugins — Entity label, Field mirror, Entity reference field, View, Tokenizer Wysiwyg and Entity form display — and includes a Layout Builder override block. It requires Field UI to expose the Manage display screens, and it conflicts with the Extra Field module (the two must not be enabled together).

---

- Add a rendered heading showing the current entity's label to a node view display with the Entity label plugin.
- Wrap that label in a configurable HTML tag and CSS class (e.g. `h1.page-title`) without theming.
- Mirror an existing field's value into a second position on the display using the Field mirror plugin.
- Re-render a field with a different core field formatter than the one used in its main placement.
- Embed a referenced entity's field (chosen from the reference target's own fields) via the Entity reference field plugin.
- Render a chosen View display inline on an entity, passing entity values or tokens as contextual arguments.
- Hide the View output automatically when the View returns no results (hide-empty option).
- Insert token-replaced, format-filtered WYSIWYG content on a display or form with the Tokenizer Wysiwyg plugin.
- Embed a full entity edit form inside a view display using the Entity form display plugin.
- Provide a custom developer plugin that computes and renders arbitrary markup as a pseudo-field.
- Restrict a custom plugin to specific entity types or bundles via `isApplicable()`.
- Offer a plugin only in the form context, only in the display context, or both, via `supported_contexts`.
- Give each plugin its own settings form (`settingsForm()`) and configuration summary (`settingsSummary()`).
- Store per-placement settings as part of the `extra_field` config entity, exportable with the rest of the site config.
- Order extra fields relative to real fields and other extra fields using the weight setting.
- Configure the same plugin differently on the default, teaser, or any custom view mode.
- Add extra fields to entity form displays (e.g. custom instructions or an embedded form) as well as view displays.
- Place efs extra fields inside a Layout Builder-enabled display through the provided override block.
- Build reusable "computed field" style output across many bundles without adding stored field storage.
- Package a set of site-specific display plugins in a custom module that depends on efs.
- Migrate away from the Extra Field module to a plugin type that also supports form displays and stored per-instance settings.
- Add a call-to-action, breadcrumb, or summary block as a themeable pseudo-field on selected content types.
- Expose an entity's related content listing as an inline View argumented by the entity's ID.
- Give editors WYSIWYG-authored boilerplate (terms, disclaimers) rendered per bundle without a stored field.
