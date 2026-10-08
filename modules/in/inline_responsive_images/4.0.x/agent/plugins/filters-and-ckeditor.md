# Plugins — filters + CKEditor 5 plugins

The module ships **plugin instances**, not new plugin *types*. Two Filter plugins and two
CKEditor 5 plugins, paired.

## Filter plugins (`src/Plugin/Filter/`)

Both are `@Filter(... type = TYPE_TRANSFORM_REVERSIBLE, weight = 100)`.

- **`FilterImageStyle`** (id `filter_imagestyle`) — in `process()` finds
  `//*[@data-entity-type="file" and @data-entity-uuid and @data-image-style]`, loads the file
  by UUID, and re-renders each match as `#theme => 'image_style'` with `#style_name` = the
  attribute value. Invalid style ids or missing files are left untouched.
- **`FilterResponsiveImageStyle`** (id `filter_responsive_image_style`) — same, keyed on
  `data-responsive-image-style`, rendered as `#theme => 'responsive_image'` with
  `#responsive_image_style_id`. It also appends CSS classes `<style_id>` and
  `image-style-<style_id>` to the `<img>`.

Both read their allowed list from `settings.image_styles` (see `configure/filters.md`) and
expose it via `tips()` for the format's filter tips.

## CKEditor 5 plugins (`inline_responsive_images.ckeditor5.yml` + `src/Plugin/CKEditor5Plugin/`)

| CKEditor5 plugin id | Toolbar item | Adds element | Enabled when |
|---|---|---|---|
| `image_imageStyle` | `DrupalImageStyle` | `<img data-image-style>` | filter `filter_imagestyle` on + `ckeditor5_image` |
| `responsive_image_responsiveImageStyle` | `DrupalResponsiveImageStyle` | `<img data-responsive-image-style>` | filter `filter_responsive_image_style` on + `ckeditor5_image` |

The PHP classes `ImageStyle` / `ResponsiveImageStyle` extend `CKEditor5PluginDefault` and only
implement `getDynamicPluginConfig()`: they read the active filter's
`settings.image_styles`, load each style's label, and pass `enabledStyles` (id → label) to the
JS plugin so the dropdown shows the right choices. The JS (`js/build/*.js`) is prebuilt and
shipped; recompiling needs the CKEditor 5 dev toolchain (see README).

## Legacy CKEditor 4 path

`inline_responsive_images.module` also alters `editor_image_dialog` (CKEditor 4): it hides the
width/height box and injects an **Image style** / **Responsive image style** select plus
previews, with validate handlers that set `src`/`width`/`height` from the chosen style. This is
only relevant on formats still using CKEditor 4.

## No plugin *types* to implement

The module defines no plugin manager, annotation, or attribute — there is nothing here for you
to subclass. To change the offered styles, edit the filter settings (config), not code.
