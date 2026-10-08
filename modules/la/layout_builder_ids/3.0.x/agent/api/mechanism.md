<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Ids — storage, rendering & validation

## How the id is collected

Hooks in `src/Hook/LayoutBuilderIdsFormAlterHooks.php` (attribute `#[Hook('form_alter')]` and
`#[Hook('form_layout_builder_configure_section_alter')]`):

- **Block:** on `layout_builder_add_block` / `layout_builder_update_block`, adds
  `$form['settings']['layout_builder_id']` (a textfield titled "Block ID"). A custom submit
  handler calls `$component->set('layout_builder_id', $value)` on the current
  `SectionComponent`.
- **Section:** on the configure-section form, adds
  `$form['layout_settings']['layout_builder_id']` ("Section ID"). Its submit handler writes the
  value into the layout configuration array (`$configuration['layout_builder_id']`).

## Where the value is stored

- **Block id** → on the `SectionComponent`, under its `additional` data as `layout_builder_id`
  (i.e. inside the layout section data of the entity/view-mode's `layout_builder__layout`).
- **Section id** → in the section's layout plugin **configuration** as `layout_builder_id`.

## How it renders

`LayoutBuilderIdsRenderSubscriber` subscribes to
`LayoutBuilderEvents::SECTION_COMPONENT_BUILD_RENDER_ARRAY` (weight 50, after core). If
`layout_builder_ids.settings:block_id` is on and the component has a `layout_builder_id`, it
sets `$build['#attributes']['id'] = $layout_builder_id`, so the chosen value becomes the DOM
`id` on the rendered block.

## Validation (`LayoutBuilderIdsService`, static methods)

- `validateId()` — the id **must start with a letter**, and may contain **only letters,
  numbers, hyphens and underscores** (no periods). Otherwise a form error is set.
- `layoutBuilderIdsCheckIds()` / `...CheckSectionIds()` / `...CheckBlockIds()` — enforce
  **uniqueness** across all sections and block components on the current page; a duplicate id
  raises "There is already a block or section with the ID …".
- `getLayoutBuilderIdDescription($type)` — the help text shown under each field.

## Service

`layout_builder_ids.layout_builder_ids_service` (class `LayoutBuilderIdsService`, also aliased
to `LayoutBuilderIdsServiceInterface`). Its useful methods are the **static** validators above;
you rarely need to call the service instance directly.
