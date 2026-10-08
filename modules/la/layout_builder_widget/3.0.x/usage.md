<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Widget turns core Layout Builder's per-entity override UI into a field widget, so an editor arranges a page's sections and blocks inline on the entity edit form instead of on the separate Layout tab, and can do it on a brand-new entity before the first save.

---

The module registers one field widget, `layout_builder_widget`, for the core `layout_section` field type (the `layout_builder__layout` field). Set it as the widget for the layout field on a bundle's *Manage form display* and the Layout Builder canvas renders inside the edit form; saving the form saves the layout with the entity, so there is no second "Layout" tab and no separate save step. To make this work it reaches deep into core Layout Builder. It subclasses core's `overrides` section storage plugin (`hook_layout_builder_section_storage_alter` swaps the class) so that new, unsaved entities get a UUID-based storage id and tempstore key, and its route subscriber widens the `layout_builder.overrides.*.view` route parameter pattern to also accept a UUID. On install it flips every `layout_section` field storage to translatable (and forces that on presave), which is what lets each translation carry its own layout — core normally does not support this. It also removes core's hook that hides the layout field on the form-display UI (via `hook_module_implements_alter` and a `#[RemoveHook]` class), suppresses the "You have unsaved changes" warning, and rewrites element/AJAX ids so several Layout Builder instances (e.g. inside Paragraphs) can coexist on one form without colliding on the hard-coded `#layout-builder` id. The widget adds three optional action controls — *Discard changes*, *Revert to defaults*, and a *content preview* toggle — configured per form-display via checkboxes; these are the only settings and they are stored under the `field.widget.settings.layout_builder_widget` config schema. Access is unchanged from core: field edit access is aligned to the section storage's own `access()` result, so who may change a layout is still governed by Layout Builder's permissions. Pair it with the separate Layout Builder Formatter module to also control where the rendered layout appears among the entity's fields.

---

- Requires the core `layout_builder` module; core `^10.3 || ^11.0`, PHP >= 8.1.
- Enable, then on *Manage form display* for a bundle set the layout field's widget to **Layout Builder Widget**.
- Only works on the `layout_section` field type (core's `layout_builder__layout` override field) — it is a widget, not a new field.
- Edit sections/blocks inline on the node (or other entity) edit form; the layout saves together with the entity on form submit.
- Works on new, unsaved entities: the widget keys tempstore by `entitytype.uuid` until the first save, so editors can lay out a page immediately.
- Each translation can hold its own layout — install makes the layout field storage translatable (and presave keeps it that way).
- Supports multiple Layout Builder instances on one form (Paragraphs, nested entities) by rewriting the otherwise-fixed `#layout-builder` DOM id to a per-storage hash.
- Three per-form-display widget settings (all default on): show *Discard changes* button, show *Revert to defaults* button, show *content preview* toggle.
- *Discard changes* deletes the layout tempstore entry; *Revert to defaults* replaces overrides with the default layout's sections.
- Removes core's separate Layout Builder local task tab for a bundle when the widget is enabled on its form display.
- Suppresses Layout Builder's "You have unsaved changes." warning message, since edits now live in the entity form.
- Runs on the admin theme (Gin, Claro, …) because the UI is on the edit form, not the frontend-themed standalone route.
- Renders via a `layout_builder` render element plus submit/AJAX actions wired to a section-storage tempstore; no custom permissions or Drush commands.
- Uninstall clears the `layout_builder.section_storage.overrides` shared tempstore so stale references to the overridden storage class do not linger.
- Complements (does not replace) the Layout Builder Formatter module, which controls display placement of the layout output.
- Modern architecture: OOP `#[Hook]` attribute classes, autowired services, immutable value objects (`StorageIdentifier`, `WidgetSettings`), a `WidgetAction` enum, and a strategy-pattern `ActionHandlerRegistry`.
- Extensible: add a service implementing `WidgetActionHandlerInterface` and register it on `layout_builder_widget.action_handler_registry` to add a custom action button.
- No settings form of its own; all configuration is the three checkboxes on the widget in *Manage form display*.
- Verify revision, validation-error, and unsaved-changes behaviour on your bundle, since inline save semantics differ from core's two-step tab flow.
