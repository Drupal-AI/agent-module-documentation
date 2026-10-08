# svg_image_field_media_bundle — agent start

Config-only submodule of **svg_image_field**. On install it imports a `vector_image` media
type (with a `field_media_svg` SVG Image Field source field and default + media-library
form/view displays), plus Acquia Site Studio "Vector Image" components when Site Studio is
present. No code, services, permissions, or settings form.

Setup: enable core `media` (and `media_library` first if used) and `svg_image_field`, then
enable this module — the "Vector image" media type appears ready to use. To configure the
field/formatter behavior of SVGs, see the parent module's docs.
