<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder form integration & where settings are stored

The module has **no config entity and no settings form of its own**. It injects two values into the
existing Layout Builder configuration forms and persists them on Layout Builder's own structures.
All of this lives in `layout_builder_context.module`.

## Install / enable

```
composer require drupal/layout_builder_context   # pulls drupal/context ^5.0
drush en layout_builder_context -y               # enables layout_builder + context too
```

Then build conditions at **Admin > Structure > Context** (`/admin/structure/context`). Only
**enabled** Contexts are offered — `layout_builder_context_option_list()` loads all `context`
entities and filters out `$context->disabled()`, keyed by `id() => label()`.

## The injected form ("Context visibility")

`hook_form_alter()` targets three form IDs:

- `layout_builder_add_block`, `layout_builder_update_block` — block components.
- `layout_builder_configure_section` — a whole section.

If there are no enabled Contexts, nothing is added. Otherwise `_layout_builder_context_form_elements()`
appends a `context_fieldset` fieldset containing:

- One or more `context_visibility[i]` **select** elements (options = enabled Contexts, `- None -`
  empty option). The count starts from the number already stored; an **"Add another"** submit
  (`layout_builder_context_form_add_context_submit` + AJAX callback
  `layout_builder_context_form_add_context_callback`, wrapper `layout-builder-context-wrapper`)
  increments `number_of_contexts` in form state and rebuilds.
- A `context_all_must_pass` **checkbox** ("All Contexts must pass", default TRUE).

`array_unshift($form['#submit'], …)` prepends the module's submit handler.

## Where the two values are saved

- **Blocks** — `_layout_builder_context_submit_block_form()` writes onto the current
  `SectionComponent`:
  `$form_object->getCurrentComponent()->set('context_visibility', array_filter($contexts))` and
  `->set('context_all_must_pass', $rule)`. `array_filter` drops the empty `- None -` selections.
  These persist as extra keys in the component's stored data.
- **Sections** — `_layout_builder_context_submit_section_form()` reads
  `$form_object->getCurrentLayout()->getConfiguration()`, `array_merge`s in
  `context_visibility` (filtered) and `context_all_must_pass`, and calls `setConfiguration()`.

Because these ride on Layout Builder's component/section data, they are stored wherever the layout
itself is stored — the `layout_builder__layout` field on the entity (overrides) or the view-display
(defaults). There is **no `config/schema` shipped for these keys** by this module, so exported YAML
carries them as untyped values; add schema yourself if strict schema checking flags them.

## Reading the values back at render time

See [../api/visibility-service.md](../api/visibility-service.md): the block subscriber reads them
off the `SectionComponent`, and `hook_preprocess_layout()` reads them from
`$variables['settings']` for sections. Both then call the `Visibility::evaluate()` service.
