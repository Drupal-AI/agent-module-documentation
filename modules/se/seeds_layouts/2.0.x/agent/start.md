<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Seeds Layouts (seeds_layouts) — agent index

Framework-agnostic **Layout Builder** section layouts plus a rich per-section settings UI. Provides
three layout plugins and a pluggable "layout field" system for classes, backgrounds and wrappers.
Version **2.0.22**, core `^10 || ^11`. Depends on core `layout_discovery` + `layout_builder`.
Global config: `/admin/config/content/seeds_layouts` (permission: *Administer Seeds Layouts*).
Part of the Seeds toolkit (Sprintive).

## What it actually provides

- **Three layouts** (`seeds_layouts.layouts.yml`), all class `\Drupal\seeds_layouts\Plugin\SeedsLayout`,
  category **Seeds**, `type: partial`:
  - `seeds_1col` — One Column (region `content`), template `templates/seeds-1col.html.twig`.
  - `seeds_2col` — Two Columns (`left`, `right`), template `seeds-2col.html.twig`.
  - `seeds_3col` — Three Columns (`left`, `center`, `right`), template `seeds-3col.html.twig`.
  - All extend `seeds-container.html.twig`.
- **`SeedsLayout` plugin** (`src/Plugin/SeedsLayout.php`) — builds the section config form as three tabs:
  - **Layout**: per-breakpoint (`desktop`/`tablet`/`mobile`) column-width radios whose options come from
    the imported framework's `seeds_layouts.columns` presets; **Reverse** columns; **Container / Full Width** toggle.
  - **Field**: renders the admin-defined **layout fields** (see below).
  - **Advanced**: free-text attribute strings for each region (`{region}_attributes`), the section
    (`section_attributes`) and the columns parent (`columns_parent_attributes`), format `key|value,key2|value2`.
- **Layout field plugin type** (`@LayoutField`, manager `plugin.manager.layout_field`, base
  `src/Plugin/LayoutFieldBase.php`). Built-ins in `src/Plugin/LayoutField/`:
  - `select` (`SelectField`) — one class chosen from a `class|Label` list → `class` attribute.
  - `checkbox` (`CheckboxField`) — toggles a configured class.
  - `background_image` (`BackgroundImageField`) — `managed_file` upload → inline `style: background-image:url(...)`
    plus `seeds-layouts-parallax` / `repeat` classes; auto-promotes the file to permanent.
  - `wrapper` (`WrapField`) — wraps a region's blocks in a chosen tag + class.
  - `blocks_wrapper` (`WrapBlocksField`, **Alpha**) — React UI (`assets/js/blocks-wrapper/`) to group
    specific blocks into a wrapper tag with attributes.
  - `hide` (`HideField`) — adds `display:none` when the section is empty.
- **Global config form** `SeedsLayoutsConfigForm` (`/admin/config/content/seeds_layouts`): general framework
  settings + a tabledrag table of custom layout fields. Tabs: **Settings**, **Columns** (`ColumnsForm`),
  **Import** (`FrameworkImportForm`).
- **Framework presets** in `config/framework/` (`bootstrap_3`, `bootstrap_4`, `foundation`, `tailwindcss`);
  importing writes `seeds_layouts.config` + `seeds_layouts.columns` (see `SeedsLayoutsManager::importFramework`).
- **Rendering**: `seeds_layouts_preprocess_layout()` in `seeds_layouts.module` turns the stored settings into
  `Attribute` objects (`section_attributes`, `{region}_attributes`, `columns_parent_attributes`) printed by the
  Twig templates, and runs each layout field's `preprocess()`.
- **Theming**: `hook_theme()` + `hook_theme_suggestions_alter()` add `__seeds_lb` template variants for many
  form / media-library / views hooks on Layout Builder routes; `libraries-extend` hooks the Media Library;
  `image_path` third-party setting adds preview images to the block/section browser;
  `LayoutBuilderBrowserEventSubscriber` adds CSS classes to the choose-block/section dialogs.
- **Block restriction**: `SeedsRestrictBlockchoose` (`@LayoutBuilderRestriction`, needs contrib
  `layout_builder_restrictions`) hides non-`block_content`/`webform_block` blocks from editors lacking
  *access all blocks layouts*.

## Permissions (`seeds_layouts.permissions.yml`)

- `administer seeds layouts` (restricted) — the global config/columns/import forms.
- `access advanced seeds layouts settings` — flips the "Container" vs "Full Width" affordance (`userFriendly`).
- `access all blocks layouts` — bypasses the block-choose restriction plugin.

Note: setting section/region/column **attributes** and layout fields is gated by Layout Builder's own
*configure … layout* permissions (the section settings form), **not** by the permissions above.

## Submodule

- `seeds_layouts_classes_extractor` — `@ClassesExtractor` plugin (needs contrib `classes_extractor`) that
  exposes classes stored in `seeds_layouts.config` to CSS build/purge tooling.

## Guides

- [Layouts, fields & attributes reference](layouts/reference.md)

## Gotchas

- Layouts are `type: partial`; the real behaviour is entirely in the settings form + `preprocess_layout`.
- Column-width options are **empty until a framework is imported** — the Layout tab radios hide themselves
  when a breakpoint has no options.
- `blocks_wrapper` is explicitly **Alpha** and warns it breaks Layout Builder drag-and-drop.
- Removing/renaming a layout leaves stored sections referencing a missing layout (standard Layout Builder trap).
- The stub prior version of these docs was wrong: there is **no** four-column, hero, or sidebar layout.
