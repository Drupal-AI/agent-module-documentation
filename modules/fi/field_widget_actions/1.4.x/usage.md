<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Widget Actions is a framework for attaching AJAX action buttons directly to field widgets on entity edit forms — a standard, plugin-based way to hang a "Suggest", "Fill with AI", "Generate alt text" or any custom button off a single field without writing a bespoke form alter.

---

Adding a button next to one field on an entity form usually means a custom form alter, hand-rolled AJAX, custom markup and a modal. This module turns that into a `FieldWidgetAction` plugin: declare the plugin with the `FieldWidgetAction` attribute (naming the field types and widget types it applies to), extend `FieldWidgetActionBase` for a direct-fill or suggestions button, `FieldWidgetFormActionBase` for a modal-form action, or `FieldWidgetRefinableFormActionBase` for a generate/refine/insert content flow. Site builders then enable and configure the action **per field widget** on *Manage form display* — the module injects the button through `hook_field_widget_complete_form_alter` / `hook_field_widget_single_element_form_alter`, stores settings in the display component's third-party settings (provider key `field_widget_actions`, one UUID-keyed map per button with `enabled`, `automatic`, `button_label`, `multiple`, `weight` and, for refinable actions, `enable_refinement`), and handles all AJAX, modal (private-tempstore state, entity-update access check), and value insertion (CKEditor / plain input / select fill commands). It ships with a config action `setComponentThirdPartySetting` for recipes, a `field_widget_actions_suggestions` theme, and a Gin admin-theme compatibility fix. The base framework does no content generation itself — that is supplied by action plugins from the AI or ECA modules, or your own. No dependencies; core `^10.3 || ^11.1 || ^12`.

---

- Add a "suggest content" button next to a text field.
- Attach an AI content-generation button to a field widget.
- Offer editors a one-click action per field.
- Generate content, refine it iteratively in a modal, then insert it.
- Render field suggestions in a modal the editor picks from.
- Add a lookup/fill button to an entity reference field.
- Give a summary field a "generate summary" action.
- Generate alt text on an image widget.
- Trigger an ECA workflow from a field button.
- Standardise custom field buttons across a site.
- Avoid bespoke form alters for each per-field button.
- Add a per-item button to each value of a multi-value field.
- Add one button acting on an entire multi-value field.
- Auto-run an action on form load (automatic buttons).
- Fill a select / options widget from an action.
- Fill a CKEditor field from an action.
- Write a custom action as a plugin without touching core forms.
- Configure which actions appear on which fields from Manage form display.
- Reorder multiple actions on a field by drag-and-drop.
- Ship field-widget-action config in a recipe via a config action.
- Support the Gin admin theme's modal dialogs.
- Prefill a field from an external source on demand.
- Attach a validation or transformation helper to a field.
- Restrict an action to specific field types and widget types.
- Prepare an editorial authoring workflow for Drupal 12.
