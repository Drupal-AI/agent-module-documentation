# Plugins provided

These are plugin *instances* the module provides (not new plugin types you extend). All live
under `src/Plugin/`.

| Plugin | Id | Class |
|---|---|---|
| Field type | `svg_image_field` (label "Vector image") | `Field/FieldType/SvgImageFieldItem` — extends core `FileItem`. |
| Field widget | `svg_image_field_widget` | `Field/FieldWidget/SvgImageFieldWidget` — upload + inline preview. |
| Field formatter | `svg_image_field_formatter` | `Field/FieldFormatter/SvgImageFieldFormatter` — inline/img rendering, sanitize, dimensions, link. |
| Field formatter | `svg_image_url_formatter` | `Field/FieldFormatter/SvgImageUrlFormatter` — outputs the file URL only. |
| Media source | `svg` (allowed field type `svg_image_field`) | `media/Source/ScalableVectorGraphic` — extends core File media source. |
| Validation constraint | `FileIsSvgImage` | `Validation/Constraint/FileIsSvgImageConstraint` (+ `…Validator`) — asserts a file is genuinely SVG by MIME and content. |

To implement your own field type/widget/formatter you use core's Field API plugin types
(`@FieldType`, `@FieldWidget`, `@FieldFormatter`) — this module does not define new plugin
managers. Sanitization uses the `enshrined/svg-sanitize` library; the module's `.module`
also alters `media_source_info` and preprocesses media-library and image-style output.
