<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layouts, fields & attributes reference

## The three layouts

| Plugin id | Label | Regions | Template |
|-----------|-------|---------|----------|
| `seeds_1col` | One Column | `content` | `templates/seeds-1col.html.twig` |
| `seeds_2col` | Two Columns | `left`, `right` | `templates/seeds-2col.html.twig` |
| `seeds_3col` | Three Columns | `left`, `center`, `right` | `templates/seeds-3col.html.twig` |

All share `class: \Drupal\seeds_layouts\Plugin\SeedsLayout`, `category: Seeds`, `type: partial`, and extend
`templates/seeds-container.html.twig`, which renders:

```twig
<section {{ section_attributes.addClass('clearfix','seeds-section',additional_classes) }}>
  ... {% if container_has_framework %}<div class={{container?container:"no-container"}}>{% endif %} ...
</section>
```

Column templates wrap regions in `<div {{columns_parent_attributes}}>` and each region in
`<div {{left_attributes}}>` etc.

## Section settings form (SeedsLayout::buildConfigurationForm)

Stored under `settings.seeds_container.seeds_body.{layout|fields|advanced}`. Three tabs:

- **Layout** — `columns.{desktop,tablet,mobile}` radios (options built from `seeds_layouts.columns`, matched to
  the layout by theme hook, rendered as icon `<img>`s); `reverse` checkbox (≥2 regions); `container` checkbox
  (only if `framework_has_container`; label/value inverted to "Full Width" for non-advanced users).
- **Field** — one sub-form per admin-defined layout field (see below).
- **Advanced** — `{region}_attributes` (one per region), `section_attributes`, `columns_parent_attributes`.
  Free text in `key|value,key2|value2` format.

On submit, chosen column classes are exploded per region into `{region}_column`; each layout field's
`getAttributes()` is merged into `layout_fields_attributes`; the advanced attribute strings are passed through
`Xss::filter()` and stored.

## Layout field plugins (`@LayoutField`)

Admin-defined globally at `/admin/config/content/seeds_layouts` (a tabledrag table); every defined field appears
on every section's **Field** tab. Default install (`config/install/seeds_layouts.config.yml`) ships:
Background Image, Advanced Wrapper (blocks_wrapper), Wrapper, Hide section, a "Color" select, a "spaces" select,
and a "Hide Section" checkbox.

| Plugin id | Class | Section-form input | Effect at render |
|-----------|-------|--------------------|------------------|
| `select` | `SelectField` | select of `class\|Label` options | adds the chosen class |
| `checkbox` | `CheckboxField` | checkbox | adds the configured class when checked |
| `background_image` | `BackgroundImageField` | managed_file + parallax/repeat | inline `style="background-image:url(<file url>)"` + `seeds-layouts-background-image` / `seeds-layouts-parallax` / `repeat` classes; attaches `seeds_layouts/parallax` |
| `wrapper` | `WrapField` | per-region: wrap? / tag / class | wraps each region's child blocks in `<tag class="…">` (skips inside the LB manage screen) |
| `blocks_wrapper` | `WrapBlocksField` (**Alpha**) | React grouping UI (`block_wrapper` element) | groups selected block UUIDs into `<tag>` with attributes from `attributesStringToArray` |
| `hide` | `HideField` | checkbox | adds `hide-section` class + `display:none` when the section has no non-empty blocks |

The layout-field plugin type is registered by `LayoutFieldManager` (dir `Plugin/LayoutField`, annotation
`Drupal\seeds_layouts\Annotation\LayoutField`), alter hook `seeds_layouts_layout_field_info`. Implement
`LayoutFieldInterface` (usually extend `LayoutFieldBase`) to add your own.

## Attribute string syntax

`SeedsLayoutsManager::attributesStringToArray()` parses `key|value` pairs separated by commas; the value is
split on spaces. Example: `class|col-6 mb-4,data-role|banner` → `class="col-6 mb-4" data-role="banner"`.
`classStringToArray` / `parseClassList` parse the newline-delimited `class|Label` lists used by selects.

## Framework presets & import

`config/framework/framework.{bootstrap_3,bootstrap_4,foundation,tailwindcss}.yml` describe `columns` (per-size
class sets + preview image) and container settings. `FrameworkImportForm` (`/admin/config/content/seeds_layouts/import`)
→ `SeedsLayoutsManager::importFramework()` writes the preset into `seeds_layouts.config` and `seeds_layouts.columns`.
`ColumnsForm` (`/…/columns`) edits column presets directly.

## Rendering pipeline (`seeds_layouts_preprocess_layout`)

Runs only for hooks matching `/seeds_\dcol/`. Builds `Attribute` objects from the stored column classes and the
parsed advanced-attribute strings (region attrs can override the computed column classes when a container is
active or the region isn't `content`), instantiates each configured layout field and calls its `preprocess()`
(to inject wrappers, background styles, hide logic) and collects `#attached` libraries. The container class comes
from `seeds_layouts.config: container_class`.

## Theming & LB integration (in `seeds_layouts.module`)

- `hook_theme()` registers `*__seeds_lb` template variants for ~30 form/media-library/views/system hooks;
  `hook_theme_suggestions_alter()` adds the `__seeds_lb` suffix on Layout Builder routes (and media-library
  contexts via `SeedsLayoutsManager::hasSuggestions()`).
- `libraries-extend` (in `.info.yml`) attaches `seeds_layouts/media_library` to the core media library.
- `image_path` third-party setting on `block_content_type` and view modes → preview `<img>` in the block/section
  browser (`hook_form_alter`, `hook_preprocess_links__seeds_lb`, `field_widget_single_element_form_alter`).
- `LayoutBuilderBrowserEventSubscriber` adds `seeds-layouts-lb-*` classes to choose-block/section AJAX results.
- `hook_menu_local_tasks_alter` repoints a translated entity's "Layout" tab at the source-language layout.
- `seeds_layouts.install` `hook_update_9001`–`9005` migrate legacy section config into the
  `seeds_container/seeds_body` structure and backfill `image_path`.
