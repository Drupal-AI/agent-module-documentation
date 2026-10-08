<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Seeds Developer Helper — tools, routes & operation

Install/enable: `drush en seeds_development`. No config, no install hook. Grant the single
permission **`access seeds development`** (`seeds_development.permissions.yml`) to developer roles;
it gates every route below. Enable core **image** / **responsive_image** and contrib
**field_group** first — they are used at runtime but not declared as dependencies.

## Image-style usage inspector

- Route `seeds_development.image_style` → `SeedsDevelopmentController::inspectImageStyle(ImageStyleInterface $image_style)`
  (`{image_style}` upcast via `entity:image_style`). Calls
  `inspector->imageStyleUseability($image_style)` and renders each returned section as a fieldset
  of links. See [../api/inspector.md](../api/inspector.md) for what it searches.
- Route `seeds_development.unused_image_style` → `inspectAllImageStyle()`: loads all image styles,
  runs the usability check on each, and lists the ids whose result is **empty** (i.e. unused) in a
  `#type => table`. It prints a note that it reads the **local config sync directory**
  (`Settings::get('config_sync_directory')`), not active config.
- `seeds_development_entity_operation_alter()` (`.module`) adds an **Inspect** operation (weight 99)
  linking to `seeds_development.image_style` on every `image_style` entity row.
- `seeds_development.links.action.yml` adds an **"Unused image styles"** local action on
  `entity.image_style.collection`.

## Field-group generator

- Local-action deriver `GroupsGeneratorLocalActions` (base plugin
  `seeds_development.form_groups_generator` in `*.links.action.yml`) creates one action per entity
  type that has a `field_ui_base_route`, titled **"Generate Basic Groups"**, appearing on
  `entity.entity_form_display.<type>.default`. Plugin class `SeedsLocalAction::getRouteParameters()`
  passes `entity_type_id`, `bundle`, and `form_mode` (from route param `form_mode_name`) to the
  target route.
- Route `seeds_development.generate_field_groups` → `generateFieldGroups($entity_type_id, $bundle, $form_mode)`
  builds three field-group definition objects — `group_tabs` (format_type `tabs`), and child tabs
  `group_basic_information` and `group_media` (each `format_type` `tab`, formatter `closed`) with a
  **hard-coded** children list (e.g. `langcode, body, field_body, field_image, field_media`, …) —
  then calls **`field_group_group_save()`** three times, shows a "Generated the field groups"
  status message, and redirects to `entity.entity_form_display.<type>.default`.
- Gated by the `access seeds development` permission; `field_group` must be installed or the
  `field_group_group_save()` call fatals. The children lists are fixed, so it only groups fields
  whose machine names match those hard-coded names.

## Responsive-image test page

- Route `seeds_development.test_responsive_images` → `testResponsiveImages()`. On first run it
  copies `assets/images/test.jpg` to `public://responsive-image-test.jpg` via
  `file_system->copy(..., FileSystemInterface::EXISTS_REPLACE)`, creates a **permanent** managed
  `File`, and caches its id in the `seeds_development` key-value store
  (`\Drupal::keyValue('seeds_development')->set('responsive_image_test_file', $fid)`). It then
  renders every `ResponsiveImageStyle` via `#theme => 'responsive_image'` against that file,
  attaching library `seeds_development/responsive_image_style_test`.
- Tab/task links: `*.links.task.yml` + `*.links.menu.yml` add a **"Test"** tab under
  `entity.responsive_image_style.collection`.

## Translate-fields form

- Route `seeds_development.translate_fields` → `TranslateFieldsForm` (form id
  `seeds_translate_fields_form`). Reads `entity_type_id` + `bundle` from the route, collects all
  `FieldConfigInterface` field definitions, and throws `NotFoundHttpException` if fewer than **2**
  languages are configured. Builds a table (via trusted pre-render callback `preRenderTable`) of a
  **Label** textfield per field per language.
- `submitForm()` writes each label into the field's config: for each language it either edits the
  base `field.field.<type>.<bundle>.<field>` config (when the base langcode matches) or the
  language config override via `languageManager->getLanguageConfigOverride()`, deleting a stale
  override first, then `->set('label', $value)->save()`. This is a standard `FormBase`
  submit (core CSRF-protected).

## `viewDisplayInspect` (stub)

Route `seeds_development.view_mode` → `viewDisplayInspect()` is an unimplemented placeholder that
just prints "Implement method: viewDisplayInspect…". No behavior; there is a `// TODO` in source.
