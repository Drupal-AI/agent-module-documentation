<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ParagraphsBehavior plugins

These are plugins of Paragraphs' own `ParagraphsBehavior` plugin type (annotation
`@ParagraphsBehavior`, base `Drupal\paragraphs\ParagraphsBehaviorBase`), discovered from
`src/Plugin/paragraphs/Behavior/`. You enable a behavior per **paragraph type** on its edit form
(`/admin/structure/paragraphs_type/<type>`, "Behavior plugins"); the plugin then adds a widget to
each paragraph's inline edit form and/or alters its render. Type-level configuration is stored in the
`paragraphs.paragraphs_type.<type>` config under `behavior_plugins.<id>`; **per-paragraph** settings
are stored on the paragraph entity via `Paragraph::setBehaviorSettings()` and read with
`getBehaviorSetting()`, so they live with the content, not in config.

## This module (`paragraphs_collection`)

### `style` — `ParagraphsStylePlugin`
Applies one or more pre-defined visual styles (discovered from `*.paragraphs.style.yml`) to a whole
paragraph.
- Type config: `groups` = `[<group_id> => ['default' => <style_id>]]`. `buildConfigurationForm`
  offers a checkbox per discovered style **group**; `validateConfigurationForm` refuses to enable if
  there are no groups or none selected.
- Per-paragraph setting: `styles` = `[<group_id> => <style_id>]` (legacy single `style` is mapped
  forward in `getStyles()`). Widget is a `select` per enabled group; advanced styles (`permission:
  true`) are filtered by `StyleDiscovery::isAllowedAccess()` unless the user holds
  `use <style-name> style`.
- `view()` (`ParagraphsStylePlugin.php:261`): for each selected style it adds class
  `paragraphs-behavior-style--<style name>`, merges the style's `libraries`, and — **from the YAML
  definition** — merges the style's `classes` into `#attributes['class']` and its `attributes` array
  into `#attributes`. These values are author/developer-trust (defined in on-disk YAML, not editor
  input); Drupal's Attribute renderer escapes them on output.
- Template suggestions: `getStyleTemplates()` returns each selected style's `template` key; the
  module's `hook_theme_suggestions_paragraph_alter` turns them into `paragraph__<bundle>__<template>`
  suggestions.
- **`|raw`/Markup note:** the AJAX callback `ParagraphsStylePlugin::ajaxStyleSelect()`
  (`ParagraphsStylePlugin.php:319-333`) assigns a style's `description` directly to a `#markup`
  element (`$return_form['style_wrapper']['style_description']['#markup'] = $description;`). The
  description originates from the discovered YAML style definition and is passed through `t()` in
  `StyleDiscovery::getStyles()`; it is admin/developer-trust content (whoever can drop a
  `*.paragraphs.style.yml` into a module/theme), not paragraph-editor input.

### `grid_layout` — `ParagraphsGridLayoutPlugin`
Lays out a paragraph's multi-value entity-reference field into columns from a discovered
`*.paragraphs.grid_layouts.yml`.
- Type config: `paragraph_reference_field` (a cardinality≠1 `entity_reference`/`entity_reference_revisions`
  field on the type) and `available_grid_layouts` (checkbox subset; empty = allow all). Validation
  requires a reference field and at least one layout.
- Per-paragraph setting: `layout` (a select). `preprocess()` (`ParagraphsGridLayoutPlugin.php:255`)
  applies the layout's `wrapper_classes` to the field wrapper and each column's `classes` to the
  referenced items in round-robin order; unknown layouts are logged as a warning. `view()` attaches
  the layout's `libraries`.

### `lockable` — `ParagraphsLockablePlugin` (access control)
Adds a "Lock content" checkbox (`locked`) whose form element is only visible to users with
`administer lockable paragraph`. The **enforcement** is `determineParagraphAccess()`
(`ParagraphsLockablePlugin.php:105`): for any non-`view` operation on a locked paragraph whose type
has the plugin enabled, it returns `AccessResult::forbiddenIf(!hasPermission('administer lockable
paragraph'))`. This is wired through `paragraphs_collection_paragraph_access()` (a
`hook_ENTITY_TYPE_access` in the `.module`), `andIf`-combined with the language behavior's result.

### `language` — `ParagraphsLanguagePlugin` (access control)
Shows/hides a paragraph per interface language. The widget only appears when the site is
multilingual; it uses a `select2` element if the `select2` module is installed, else a plain
`select`.
- Per-paragraph setting: `container` = `['visibility' => 'always'|'show'|'hide', 'languages' => [...]]`.
- Enforcement `determineParagraphAccess()` (`ParagraphsLanguagePlugin.php:151`) runs only for the
  `view` operation: `show` forbids when current language is not in the list; `hide` forbids when it
  is. Both results carry cacheable dependencies on the paragraph and its type.

Access note: the two access methods only ever return `forbidden` or `neutral` (never `allowed`), so
they can restrict but never grant access — the correct pattern for an access hook.

## Demo submodule (`paragraphs_collection_demo`) behaviors

Enable `paragraphs_collection_demo` to get these (`modules/paragraphs_collection_demo/src/Plugin/paragraphs/Behavior/`):

- `accordion` — `ParagraphsAccordionPlugin`. Type config `paragraph_accordion_field` (a cardinality≠1
  field); adds an `accordion` class + `paragraphs_collection_demo/accordion` library. Needs the
  `jquery_ui_accordion` module.
- `anchor` — `ParagraphsAnchorPlugin`. Per-paragraph `anchor` textfield → sets HTML `id`
  `scrollto-<anchor>` and class `paragraphs-anchor-link` on the paragraph wrapper (value rendered as
  an attribute, so escaped by Drupal's Attribute system); the permalink JS
  (`paragraphs_collection_demo/anchor`) is attached only when
  `paragraphs_collection_demo.settings:anchor.show_permalink` is true.
- `background` — `ParagraphsBackgroundPlugin`. Type config `background_image_field` (an image field);
  tags that field `paragraphs-behavior-background--image` and other children
  `--element`, attaches `paragraphs_collection_demo/background`.
- `slider` — `ParagraphsSliderPlugin`. Type config `field_name` + `slick_slider` (allowed Slick
  optionsets); per-paragraph `slick_slider` picks the optionset. Renders the mapped multi-value field
  through the **Slick** manager (`slick.manager`). Requires the `slick` module.
