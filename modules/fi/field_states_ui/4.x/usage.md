<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field States UI exposes Drupal's form **States API** (`#states`) through the Manage form display UI, so site builders can make a field show/hide, require, enable, etc. based on another field's value — without writing PHP.

---

The module lets you attach one or more "field states" to a field's widget on any entity's **Manage form display** page. Each state is a plugin of the module's own **FieldState** plugin type (managed by `plugin.manager.field_states_ui.fieldstate` / `FieldStateManager`); the built-in states mirror the States API: `visible`, `invisible`, `required`, `optional`, `enabled`, `disabled`, `checked`, `unchecked`, `expanded`, `collapsed`. A configured state stores a **target** field, a **comparison** (e.g. `value`, `empty`, `filled`, `checked`, `unchecked`), and a **value**; at form build time `hook_field_widget_complete_form_alter()` asks the manager to translate the states into a `#states` array on the widget, producing dynamic client-side behaviour (e.g. "only show this field when *Country* is *Canada*"). Configuration is persisted as a **third-party setting** on the widget's component inside the `entity_form_display` config entity, under `third_party_settings.field_states_ui.field_states` — a list of `{id, data:{target, comparison, value}, uuid}` entries. There is no central admin settings page (`configure: null`), no permissions of its own, and no Drush commands; it ships config schema and a plugin manager, and supports 50+ widgets across core and many contrib field types. Because it is UI-driven and stored per widget, states are exported and deployed as part of your form-display config.

---

- Show a "Other (please specify)" text field only when a select list is set to "Other".
- Make a field required only when a checkbox is checked.
- Hide a set of fields until a category field has a particular value.
- Require a phone number field only when "Contact by phone" is selected.
- Disable a field while another field is empty.
- Enable a discount-code field only once a "Has coupon" checkbox is ticked.
- Mark a field optional dynamically based on another field's state.
- Reveal shipping-address fields only when "Ship to different address" is checked.
- Collapse/expand a details element based on a related field's value.
- Check/uncheck a boolean automatically in response to another field (checked/unchecked states).
- Build conditional forms on nodes, users, taxonomy terms, media, paragraphs, etc.
- Configure the behaviour per form mode (default vs a custom form mode).
- Let non-developers assemble multi-condition form logic through the widget settings UI.
- Combine several states on one field (e.g. visible when X and required when Y).
- Apply States API behaviour to contrib field widgets (Address, Paragraphs, Select2, Webform, …).
- Avoid writing custom `#states` arrays or form alters in a module.
- Export conditional-field logic as part of `entity_form_display` config for deployment.
- Target a sibling field within a paragraph/inline-entity-form via the parents-aware target handling.
- Show help/markup fields only in relevant contexts.
- Reduce form clutter by hiding irrelevant fields until needed.
- Standardise conditional behaviour across content types via reusable form-display config.
- Extend the available states by writing a custom FieldState plugin.
- Prototype dynamic form behaviour quickly during content-type building.
- Require one of two mutually-dependent fields based on the other's value.
- Improve data quality by requiring fields only when contextually relevant.
