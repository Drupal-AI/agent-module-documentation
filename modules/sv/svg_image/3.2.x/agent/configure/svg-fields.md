# Enabling & configuring SVG on an Image field

There is **no dedicated settings page** and `configure` is null. SVG support is turned on
per field and controlled through the normal field/display forms.

## 1. Allow SVG uploads
On the field's storage/settings form (**Structure → Content type → Manage fields →
[image field] → settings**) add `svg` to **Allowed file extensions**, e.g.
`png gif jpg jpeg svg`. The overridden `image_image` widget (`SvgImageWidget`) then:
- allows the `.svg` upload (removes core's `FileIsImage` validator),
- intersects your extensions with the toolkit's supported set (plus `svg`),
- renders a real SVG preview in the edit form.

## 2. Choose how SVGs display
On **Manage display**, the `image` formatter (`SvgImageFormatter`) gains two extra settings
(stored in the field display config, schema added via `hook_config_schema_info_alter`):

| Setting key | Type | Meaning |
|---|---|---|
| `svg_render_as_image` | bool (default TRUE) | TRUE → render as `<img>`; FALSE → inline `<svg>` markup (sanitized). |
| `svg_attributes.width` | int / null | Force width (px) on rendered SVG. |
| `svg_attributes.height` | int / null | Force height (px) on rendered SVG. |

Notes:
- When width/height are empty and an image style is set, dimensions are derived from the
  SVG (or default 64×64) and the style's `transformDimensions()`.
- Inline SVG output is sanitized with `enshrined/svg-sanitize` and has its `<?xml…?>` /
  `<!DOCTYPE…>` stripped.
- The `image_url` formatter (`SvgImageUrlFormatter`) returns the raw file URL for SVGs when
  an image style is selected (image styles can't rewrite SVGs).

## Uninstall
`hook_uninstall` removes `svg` from every image field's extensions, drops the
`svg_render_as_image` / `svg_attributes` display settings, and restores the core `image`
module dependency — so removal is clean.
