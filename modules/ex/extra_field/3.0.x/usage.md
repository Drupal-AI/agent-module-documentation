<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extra Field turns Drupal's `hook_entity_extra_field_info()` pseudo-fields into two discoverable plugin types, so a module can drop a class into `Plugin/ExtraField/Display` or `Plugin/ExtraField/Form` and immediately get a draggable, weightable "field" on any entity's *Manage display* / *Manage form display* page.

---

The module defines two plugin managers — `plugin.manager.extra_field_display` (subdirectory `Plugin/ExtraField/Display`, interface `ExtraFieldDisplayInterface`, attribute `Drupal\extra_field\Attribute\ExtraFieldDisplay`, legacy annotation `@ExtraFieldDisplay`) and `plugin.manager.extra_field_form` (subdirectory `Plugin/ExtraField/Form`, interface `ExtraFieldFormInterface`, attribute/annotation `ExtraFieldForm`). A plugin declares `id`, `label`, optional `description`, a `bundles` list, an optional `weight` and `visible` flag. `bundles` entries are `entity_type.bundle`, `entity_type.*` for every bundle of a type, or `*.*` for every content entity type; the manager expands wildcards through the entity type manager. `extra_field_entity_extra_field_info()` merges both managers' `fieldInfo()` output, exposing each plugin as a pseudo-field whose machine name is **`extra_field_` + plugin id**. At render time `extra_field_entity_view()` asks the display manager to instantiate every matching plugin whose component is enabled on the current view display and puts its `view()` return value into `$build[extra_field_<id>]`; `extra_field_form_alter()` does the equivalent for content entity forms, calling `formElement($form, $form_state)` and assigning the result to `$form[extra_field_<id>]`. Three base classes are provided: `ExtraFieldDisplayBase` (raw output, no wrappers), `ExtraFieldDisplayFormattedBase` (wraps the output in `#theme: field` so field templates, labels, label display, langcode and translatability apply) and `ExtraFieldFormBase` (form plugins, with access to the entity, form display and form mode). Both plugin sets can be altered with `hook_extra_field_display_info_alter()` / `hook_extra_field_form_info_alter()`. The project also ships Drush code generators and a bundled `extra_field_example` submodule with ready-to-copy plugins.

---

- Render an entity's "related content" list as a positionable field on the node display.
- Show a computed price / discount / stock line on a product without a stored field.
- Print a formatted "last updated by X on Y" line as a field editors can move in *Manage display*.
- Concatenate a taxonomy reference field's labels into a single readable line.
- Add a "share this" widget as a real, weightable field instead of a block.
- Expose an external API lookup (weather, stock ticker, ratings) as a field on a node.
- Build a breadcrumb-like trail from an entity's own data and let site builders position it.
- Add a QR code or barcode generated from the entity id to a product view mode.
- Give a media entity a computed "file size / dimensions" pseudo-field.
- Add a custom submit button ("Save and notify") to every node form, positioned with the other fields.
- Insert a plain-text disclaimer or legal notice into a specific entity form.
- Add a voucher-code text input to the user registration form that resolves to a hidden entity reference.
- Add a per-form-mode confirmation checkbox that is not stored on the entity.
- Attach validation to a form without writing a full `hook_form_alter()` and juggling form ids.
- Provide one plugin for every bundle of an entity type with the `node.*` wildcard.
- Provide a plugin for every content entity type at once with `*.*`.
- Extend a third-party module's extra field to more bundles via `hook_extra_field_display_info_alter()`.
- Hide an extra field per view mode by unchecking it in *Manage display* — no code change.
- Give the extra field a label and label display (above/inline/hidden) using `ExtraFieldDisplayFormattedBase`.
- Print an extra field explicitly in a Twig template with `{{ content.extra_field_<plugin_id> }}`.
- Mark an extra field's output empty (`$this->isEmpty = TRUE`) so no field wrapper is emitted.
- Make an extra field translatable and language-aware by overriding `isTranslatable()` / `getLangcode()`.
- Attach cacheable metadata from referenced entities so the extra field invalidates correctly.
- Inject services into an extra field plugin via `ContainerFactoryPluginInterface`.
- Replace a pile of preprocess functions with typed, testable plugin classes.
- Scaffold new plugins from the bundled Drush generator templates or the `extra_field_example` submodule.
