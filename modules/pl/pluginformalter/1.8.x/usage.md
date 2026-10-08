<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Plugin Form Alter lets you replace `hook_form_alter()` implementations with discoverable, weighted **FormAlter plugin classes**, keyed by form id or base form id, so form alterations live in their own class instead of a monolithic `.module` file.

---

The module defines three plugin managers — `plugin.manager.form_alter` (annotation `@FormAlter`), `plugin.manager.form_alter.paragraphs` (`@ParagraphsFormAlter`), and `plugin.manager.form_alter.ief` (`@InlineEntityFormAlter`) — all discovering classes under a module's `src/Plugin/FormAlter/` namespace. Its own `hook_form_alter()` asks the FormAlter manager for every plugin whose `form_id` or `base_form_id` matches the current form (wildcards via `*` are supported, base-form-id plugins run before form-id plugins, and a `weight` orders plugins within each group) and calls each plugin's `formAlter(&$form, $form_state, $form_id)`. A FormAlter plugin extends `FormAlterBase`, declares `id`, optional `label`, an array `form_id` **or** `base_form_id`, and an optional integer `weight`, and implements `formAlter()`. Parallel hooks bridge Paragraphs subforms (matched by `paragraph_type`) and Inline Entity Form subforms (matched by `type` = `entity_form`/`reference_form`/`table_fields`, plus `entity_type`/`bundle`/etc.) to their respective managers. When Webprofiler is present, its Forms data collector is decorated to list which plugins altered each form. **Important:** on Drupal ≥ 11.2 the module emits an `E_USER_DEPRECATED` notice for every plugin invoked — FormAlter plugins stop being called in Drupal 12; the recommended replacement is core OOP Hooks. There is no configuration, UI, permission, or Drush command.

---

- Move a bulky `hook_form_FORM_ID_alter()` into a dedicated, testable FormAlter plugin class.
- Alter a specific form by `form_id` (e.g. `node_article_form`) from a plugin.
- Alter a family of forms by `base_form_id` (e.g. all node forms via `node_form`).
- Match many forms with a wildcard, e.g. `form_id = {"node_*_edit_form"}`.
- Order multiple alterations of the same form deterministically using plugin `weight`.
- Let several modules each contribute independent FormAlter plugins to the same form.
- Add a submit/validate handler or extra field to a form from a plugin instead of a hook.
- Inject default values or `#access` rules into a form via a small plugin.
- Alter a Paragraphs subform by `paragraph_type` using a ParagraphsFormAlter plugin.
- Alter an Inline Entity Form entity subform (`type: entity_form`) scoped by entity type/bundle.
- Alter an IEF reference form (`type: reference_form`) for a given entity type.
- Alter the IEF table fields (`type: table_fields`) shown for referenced entities.
- Keep form-alter logic organised per feature module under `src/Plugin/FormAlter/`.
- Use dependency injection in a form alteration by overriding `create()` on `FormAlterBase`.
- Group related alterations (validation, defaults, UI tweaks) into separate weighted plugins.
- Inspect which plugins altered a given form using the decorated Webprofiler Forms collector.
- Provide reusable form tweaks shipped inside a contrib/custom module without touching `.module`.
- Conditionally alter a form based on `$form_state` build info from within the plugin.
- Apply the same alteration across multiple form ids by listing them in the `form_id` array.
- Prototype form changes as classes that are easy to unit test in isolation.
- Audit/migrate legacy `hook_form_alter` code toward OOP before Drupal 12 (where this module's plugins stop running).
